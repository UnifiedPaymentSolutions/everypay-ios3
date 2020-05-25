//
//  PaymentAPI.m
//  everyPay_v3
//


#import "PaymentAPI.h"

@implementation PaymentAPI

+ (PaymentAPI *)sharedInstance {
    static dispatch_once_t onceToken;
    static PaymentAPI *sharedInstance = nil;
    // make sure it run only one
    dispatch_once(&onceToken, ^{
        if (!sharedInstance) {
            sharedInstance = [[PaymentAPI alloc] init];
        }
    });
    return sharedInstance;
}

//API card payment
- (void)callAPIPayment:(NSString *)cardNumber andName:(NSString *)name andMonth:(NSString *)month andYear:(NSString *)year andCVC:(NSString *)cvc andAPIUsername:(NSString *)apiUsername andMobileToken:(NSString *)mobileToken andHost:(NSString *)host withCompletion:(void(^)(NSDictionary *dict))completion failureBlock:(void(^)(NSInteger failureCode, NSString *msgError))failure{
    NSError *error;
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@",mobileToken];
    configuration.HTTPAdditionalHeaders = @{@"Authorization": authValue};
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:nil delegateQueue:nil];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",host,@"/api/v3/mobile_payments/card_details"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:60.0];
    
    
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    
    [request setHTTPMethod:@"POST"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    params[@"api_username"] = apiUsername;
    
    NSMutableDictionary *cardDetail = [[NSMutableDictionary alloc] init];
    cardDetail[@"cc_number"] = cardNumber;
    cardDetail[@"month"] = month;
    cardDetail[@"year"] = year;
    cardDetail[@"holder_name"] = name;
    cardDetail[@"cvc"] = cvc;
    
    params[@"cc_details"] = cardDetail;
    params[@"token_consented"] = @(1);
    params[@"nonce"] = [StringUtils randomStringWithLength:30];
    params[@"timestamp"] = [StringUtils datetimeToString:[NSDate date] andDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    
    NSData *postData = [NSJSONSerialization dataWithJSONObject:params options:0 error:&error];
    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (!error) {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            responseDictionary = [StringUtils nestedDictionaryByReplacingNullsWithNil:responseDictionary];
            NSLog(@"The response is - %@",responseDictionary);
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(responseDictionary);
                });
            }
        } else {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(0,@"");
                });
            }
        }
    }];
    
    [postDataTask resume];
}

// API get status webview
- (void) getDataFrom:(NSString *)url withCompletion:(void(^)(NSDictionary *dict))completion failureBlock:(void(^)(NSInteger failureCode, NSString *msgError))failure {
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
    //create the Method "GET"
    [urlRequest setHTTPMethod:@"GET"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:urlRequest completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *)response;
        if(httpResponse.statusCode == 200) {
            NSError *parseError = nil;
            NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
            responseDictionary = [StringUtils nestedDictionaryByReplacingNullsWithNil:responseDictionary];
            NSLog(@"The response is - %@",responseDictionary);
            if (completion) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    completion(responseDictionary);
                });
            }
        } else {
            NSLog(@"Error");
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(0,@"Error");
                });
            }
        }
    }];
    [dataTask resume];
}

@end

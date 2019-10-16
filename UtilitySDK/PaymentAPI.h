//
//  PaymentAPI.h
//  everyPay_v2
//


#import <Foundation/Foundation.h>
#import "StringUtils.h"

NS_ASSUME_NONNULL_BEGIN

@interface PaymentAPI : NSObject

+ (PaymentAPI *)sharedInstance;
- (void)callAPIPayment:(NSString *)cardNumber andName:(NSString *)name andMonth:(NSString *)month andYear:(NSString *)year andCVC:(NSString *)cvc andAPIUsername:(NSString *)apiUsername andMobileToken:(NSString *)mobileToken andHost:(NSString *)host withCompletion:(void(^)(NSDictionary *dict))completion failureBlock:(void(^)(NSInteger failureCode, NSString *msgError))failure;
- (void) getDataFrom:(NSString *)url withCompletion:(void(^)(NSDictionary *dict))completion failureBlock:(void(^)(NSInteger failureCode, NSString *msgError))failure;

@end

NS_ASSUME_NONNULL_END

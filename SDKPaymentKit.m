//
//  SDKPaymentKit.m
//  everyPay_v2
//


#import "SDKPaymentKit.h"

@implementation SDKPaymentKit

+ (SDKPaymentKit *)sharedInstance {
    static SDKPaymentKit *_sharedInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        if (!_sharedInstance) {
            _sharedInstance = [[SDKPaymentKit alloc] init];
        }
    });
    return _sharedInstance;
}

- (void) paymentWithHost:(NSString *)host andMobileToken:(NSString *)mobileToken andCurrency:(NSString *)currency andPaymentLink:(NSString *)paymentLink andAmount:(NSString *)amount andPaymentType:(NSString *)source andAPIUsername:(NSString *)apiUsername andDelegate:(id)target {
    //Card Payment
    if ([source isEqualToString:@"card"]) {
        CardPaymentViewController *cardVC = [[CardPaymentViewController alloc] initWithNibName:@"CardPaymentViewController" bundle:nil];
        cardVC.host = host;
        cardVC.mobile_access_token = mobileToken;
        cardVC.currency = currency;
        cardVC.payment_link = paymentLink;
        cardVC.amount = amount;
        cardVC.apiUsername = apiUsername;
        cardVC.target = target;
        cardVC.delegate = target;
        [self presentViewController:cardVC andParentViewController:(UIViewController *)target];
    //Webview Payment
    } else {
        WebViewPayment *webview = [[WebViewPayment alloc] initWithNibName:@"WebViewPayment" bundle:nil];
        webview.urlPayment = paymentLink;
        webview.delegate = target;
        [self presentViewController:webview andParentViewController:(UIViewController *)target];
    }
}

- (void)presentViewController:(UIViewController *)viewVC andParentViewController:(UIViewController *)parentVC {
    UINavigationController *navigationController =[[UINavigationController alloc] initWithRootViewController:viewVC];
    //now present this navigation controller modally
    [parentVC presentViewController:navigationController
                             animated:YES
                           completion:^{
                               
                           }];
}

@end

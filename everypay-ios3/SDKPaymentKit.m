//
//  SDKPaymentKit.m
//  everyPay_v3
//


#import "SDKPaymentKit.h"

@implementation SDKPaymentKit

+ (instancetype)initWithUserName:(NSString *)apiUsername andHost:(NSString *)host andAmount:(NSString *)amount andCurrency:(NSString *)currency {
    SDKPaymentKit *sdkPayment = [[SDKPaymentKit alloc] init];
    sdkPayment.host = host;
    sdkPayment.apiUsername = apiUsername;
    sdkPayment.amount = amount;
    sdkPayment.currency = currency;
    return sdkPayment;
}

- (void) paymentWithMobileToken:(NSString *)mobileToken andPaymentLink:(NSString *)paymentLink andPaymentType:(NSString *)source andDelegate:(id)target {
    if ([source isEqualToString:@"card"]) {
        NSBundle *bundle = [NSBundle bundleForClass:CardPaymentViewController.class];
        CardPaymentViewController *cardVC = [[CardPaymentViewController alloc] initWithNibName:@"CardPaymentViewController" bundle:bundle];
        cardVC.host = self.host;
        cardVC.mobile_access_token = mobileToken;
        cardVC.currency = self.currency;
        cardVC.payment_link = paymentLink;
        cardVC.amount = self.amount;
        cardVC.apiUsername = self.apiUsername;
        cardVC.target = target;
        cardVC.delegate = target;
        [self presentViewController:cardVC andParentViewController:(UIViewController *)target];
    } else {
        NSBundle *bundle = [NSBundle bundleForClass:WebViewPayment.class];
        WebViewPayment *webview = [[WebViewPayment alloc] initWithNibName:@"WebViewPayment" bundle:bundle];
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

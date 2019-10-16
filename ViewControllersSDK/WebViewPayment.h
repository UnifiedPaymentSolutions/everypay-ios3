//
//  WebViewPayment.h
//  everyPay_v2
//


#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "StringUtils.h"
#import "PaymentAPI.h"

@protocol WebViewPaymentDelegate <NSObject>

- (void)paymentSuccess;
- (void)paymentFailure;

@end

NS_ASSUME_NONNULL_BEGIN

@interface WebViewPayment : UIViewController <WKNavigationDelegate, WKUIDelegate>

@property (weak, nonatomic) id <WebViewPaymentDelegate> delegate;
@property (copy, nonatomic) NSString *urlPayment;
@property (copy, nonatomic) NSString *refrenceID;
@property (strong, nonatomic) WKWebView *WKWebview;
@property (assign, nonatomic) BOOL isCompleted;

@end

NS_ASSUME_NONNULL_END

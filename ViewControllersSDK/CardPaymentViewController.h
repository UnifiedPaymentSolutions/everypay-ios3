//
//  CardPaymentViewController.h
//  everyPay_v2
//


#import <UIKit/UIKit.h>
#import "WebViewPayment.h"
#import "StringUtils.h"
#import "PaymentAPI.h"
#import "SDKPaymentSettings.h"

@import SkyFloatingLabelTextField;

@protocol CardPaymentViewControllerDelegate <NSObject>

- (void)paymentSuccess;
- (void)paymentFailure;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CardPaymentViewController : UIViewController <UITextFieldDelegate, NSURLSessionDelegate>
@property (weak, nonatomic) id <CardPaymentViewControllerDelegate> delegate;
@property (copy, nonatomic) NSString *host;
@property (copy, nonatomic) NSString *mobile_access_token;
@property (copy, nonatomic) NSString *currency;
@property (copy, nonatomic) NSString *payment_link;
@property (copy, nonatomic) NSString *amount;
@property (copy, nonatomic) NSString *apiUsername;
@property (weak, nonatomic) IBOutlet UILabel *lblHost;
@property (weak, nonatomic) IBOutlet UIView *viewCardNumber;
@property (weak, nonatomic) IBOutlet UIView *viewName;
@property (weak, nonatomic) IBOutlet UIView *viewDate;
@property (weak, nonatomic) IBOutlet UIView *viewCSC;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *tfCardNumber;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *tfName;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *tfDate;
@property (weak, nonatomic) IBOutlet SkyFloatingLabelTextField *tfCSC;
@property (weak, nonatomic) IBOutlet UIButton *btnPay;
@property (strong, nonatomic) id target;
@property (strong, nonatomic) IBOutletCollection(SkyFloatingLabelTextField) NSArray *textFieldCollection;
- (IBAction)clickPay:(id)sender;

@end

NS_ASSUME_NONNULL_END

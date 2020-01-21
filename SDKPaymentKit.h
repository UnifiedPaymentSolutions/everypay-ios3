//
//  SDKPaymentKit.h
//  everyPay_v3
//


#import <Foundation/Foundation.h>
#import "WebViewPayment.h"
#import "CardPaymentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SDKPaymentKit : NSObject

+ (instancetype)initWithUserName:(NSString *)apiUsername andHost:(NSString *)host andAmount:(NSString *)amount andCurrency:(NSString *)currency;
- (void) paymentWithMobileToken:(NSString *)mobileToken andPaymentLink:(NSString *)paymentLink andPaymentType:(NSString *)source andDelegate:(id)target;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *apiUsername;
@property (nonatomic, copy) NSString *amount;
@property (nonatomic, copy) NSString *currency;
@end

NS_ASSUME_NONNULL_END

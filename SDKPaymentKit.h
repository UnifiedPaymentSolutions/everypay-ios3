//
//  SDKPaymentKit.h
//  everyPay_v2
//
//  Created by Duc.LT on 10/10/19.
//  Copyright © 2019 MobiLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebViewPayment.h"
#import "CardPaymentViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface SDKPaymentKit : NSObject

+ (SDKPaymentKit *)sharedInstance;
- (void) paymentWithHost:(NSString *)host andMobiteToken:(NSString *)mobileToken andCurrency:(NSString *)currency andPaymentLink:(NSString *)paymentLink andAmount:(NSString *)amount andPaymentType:(NSString *)source andAPIUsername:(NSString *)apiUsername andDelegate:(id)target;

@end

NS_ASSUME_NONNULL_END

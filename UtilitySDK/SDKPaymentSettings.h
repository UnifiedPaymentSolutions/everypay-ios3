//
//  SDKPaymentSettings.h
//  everyPay_v2
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
#define TEXT_COLOUR @"everypayv3.TEXT_COLOUR"
#define PLACEHOLDER_COLOUR @"everypayv3.PLACEHOLDER_COLOUR"
#define TITLE_COLOUR @"everypayv3.TITLE_COLOUR"
#define LINE_COLOUR @"everypayv3.LINE_COLOUR"
#define ERROR_COLOUR @"everypayv3.ERROR_COLOUR"
#define LINE_ERROR_COLOUR @"everypayv3.LINE_ERROR_COLOUR"
#define TEXT_ERROR_COLOUR @"everypayv3.TEXT_ERROR_COLOUR"
#define TITLE_ERROR_COLOUR @"everypayv3.TITLE_ERROR_COLOUR"
#define SELECTED_TITLE_COLOUR @"everypayv3.SELECTED_TITLE_COLOUR"
#define SELECTED_LINE_COLOUR @"everypayv3.SELECTED_LINE_COLOUR"
#define CARD_NUMBER_ERROR_MESSAGE @"everypayv3.CARD_NUMBER_ERROR_MESSAGE"
#define CARD_NAME_ERROR_MESSAGE @"everypayv3.CARD_NAME_ERROR_MESSAGE"
#define EXPIRATION_DATE_ERROR_MESSAGE @"everypayv3.EXPIRATION_DATE_ERROR_MESSAGE"
#define CVC_ERROR_MESSAGE @"everypayv3.CVC_ERROR_MESSAGE"

@interface SDKPaymentSettings : NSObject

+(void)setTextColor:(UIColor *)textColor;
+(UIColor *)getTextColor;

+(void)setPlaceholderColor:(UIColor *)placeholderColor;
+(UIColor *)getPlaceholderColor;

+(void)setTitleColor:(UIColor *)titleColor;
+(UIColor *)getTitleColor;

+(void)setLineColor:(UIColor *)lineColor;
+(UIColor *)getLineColor;

+(void)setErrorColor:(UIColor *)errorColor;
+(UIColor *)getErrorColor;

+(void)setLineErrorColor:(UIColor *)lineErrorColor;
+(UIColor *)getLineErrorColor;

+(void)setTextErrorColor:(UIColor *)textErrorColor;
+(UIColor *)getTextErrorColor;

+(void)setTitleErrorColor:(UIColor *)titleErrorColor;
+(UIColor *)getTitleErrorColor;

+(void)setSelectedTitleColor:(UIColor *)selectedTitleColor;
+(UIColor *)getSelectedTitleColor;

+(void)setSelectedLineColor:(UIColor *)selectedLineColor;
+(UIColor *)getSelectedLineColor;

+(void)setCardNumberErrorMessage:(NSString *)cardNumberErrorMessage;
+(NSString *)getCardNumberErrorMessage;

+(void)setCardNameErrorMessage:(NSString *)cardNameErrorMessage;
+(NSString *)getCardNameErrorMessage;

+(void)setExpirationDateErrorMessage:(NSString *)expirationDateErrorMessage;
+(NSString *)getExpirationDateErrorMessage;

+(void)setCVCErrorMessage:(NSString *)cvcErrorMessage;
+(NSString *)getCVCErrorMessage;

@end

NS_ASSUME_NONNULL_END

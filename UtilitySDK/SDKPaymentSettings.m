//
//  SDKPaymentSettings.m
//  everyPay_v3
//

#import "SDKPaymentSettings.h"

@implementation SDKPaymentSettings

+(void)setTextColor:(UIColor *)textColor
{
    NSData *textColorData = [NSKeyedArchiver archivedDataWithRootObject:textColor];
    [[NSUserDefaults standardUserDefaults] setObject:textColorData forKey:TEXT_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getTextColor
{
    NSData *textColorData = [[NSUserDefaults standardUserDefaults] objectForKey:TEXT_COLOUR];
    UIColor *textColor = [NSKeyedUnarchiver unarchiveObjectWithData:textColorData];
    if(textColor)
    {
        return textColor;
    }
    return [UIColor blackColor];
}

+(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    NSData *placeholderColorData = [NSKeyedArchiver archivedDataWithRootObject:placeholderColor];
    [[NSUserDefaults standardUserDefaults] setObject:placeholderColorData forKey:PLACEHOLDER_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getPlaceholderColor
{
    NSData *placeholderColorData = [[NSUserDefaults standardUserDefaults] objectForKey:PLACEHOLDER_COLOUR];
    UIColor *placeholderColor = [NSKeyedUnarchiver unarchiveObjectWithData:placeholderColorData];
    if(placeholderColor)
    {
        return placeholderColor;
    }
    return [UIColor grayColor];
}

+(void)setTitleColor:(UIColor *)titleColor
{
    NSData *titleColorData = [NSKeyedArchiver archivedDataWithRootObject:titleColor];
    [[NSUserDefaults standardUserDefaults] setObject:titleColorData forKey:TITLE_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getTitleColor
{
    NSData *titleColorData = [[NSUserDefaults standardUserDefaults] objectForKey:TITLE_COLOUR];
    UIColor *titleColor = [NSKeyedUnarchiver unarchiveObjectWithData:titleColorData];
    if(titleColor)
    {
        return titleColor;
    }
    return [UIColor colorWithRed:249.0/255.0 green:124.0/255.0 blue:43.0/255.0 alpha:1.0];
}

+(void)setLineColor:(UIColor *)lineColor
{
    NSData *lineColorData = [NSKeyedArchiver archivedDataWithRootObject:lineColor];
    [[NSUserDefaults standardUserDefaults] setObject:lineColorData forKey:LINE_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getLineColor
{
    NSData *lineColorData = [[NSUserDefaults standardUserDefaults] objectForKey:LINE_COLOUR];
    UIColor *lineColor = [NSKeyedUnarchiver unarchiveObjectWithData:lineColorData];
    if(lineColor)
    {
        return lineColor;
    }
    return [UIColor colorWithRed:249.0/255.0 green:124.0/255.0 blue:43.0/255.0 alpha:1.0];
}

+(void)setErrorColor:(UIColor *)errorColor
{
    NSData *errorColorData = [NSKeyedArchiver archivedDataWithRootObject:errorColor];
    [[NSUserDefaults standardUserDefaults] setObject:errorColorData forKey:ERROR_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getErrorColor
{
    NSData *errorColorData = [[NSUserDefaults standardUserDefaults] objectForKey:ERROR_COLOUR];
    UIColor *errorColor = [NSKeyedUnarchiver unarchiveObjectWithData:errorColorData];
    if(errorColor)
    {
        return errorColor;
    }
    return [UIColor redColor];
}

+(void)setLineErrorColor:(UIColor *)lineErrorColor
{
    NSData *lineErrorColorData = [NSKeyedArchiver archivedDataWithRootObject:lineErrorColor];
    [[NSUserDefaults standardUserDefaults] setObject:lineErrorColorData forKey:LINE_ERROR_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getLineErrorColor
{
    NSData *lineErrorColorData = [[NSUserDefaults standardUserDefaults] objectForKey:LINE_ERROR_COLOUR];
    UIColor *lineErrorColor = [NSKeyedUnarchiver unarchiveObjectWithData:lineErrorColorData];
    if(lineErrorColor)
    {
        return lineErrorColor;
    }
    return [UIColor redColor];
}

+(void)setTextErrorColor:(UIColor *)textErrorColor
{
    NSData *textErrorColorData = [NSKeyedArchiver archivedDataWithRootObject:textErrorColor];
    [[NSUserDefaults standardUserDefaults] setObject:textErrorColorData forKey:TEXT_ERROR_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getTextErrorColor
{
    NSData *textErrorColorData = [[NSUserDefaults standardUserDefaults] objectForKey:TEXT_ERROR_COLOUR];
    UIColor *textErrorColor = [NSKeyedUnarchiver unarchiveObjectWithData:textErrorColorData];
    if(textErrorColor)
    {
        return textErrorColor;
    }
    return [UIColor redColor];
}

+(void)setTitleErrorColor:(UIColor *)titleErrorColor
{
    NSData *titleErrorColorData = [NSKeyedArchiver archivedDataWithRootObject:titleErrorColor];
    [[NSUserDefaults standardUserDefaults] setObject:titleErrorColorData forKey:TITLE_ERROR_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getTitleErrorColor
{
    NSData *titleErrorColorData = [[NSUserDefaults standardUserDefaults] objectForKey:TITLE_ERROR_COLOUR];
    UIColor *titleErrorColor = [NSKeyedUnarchiver unarchiveObjectWithData:titleErrorColorData];
    if(titleErrorColor)
    {
        return titleErrorColor;
    }
    return [UIColor redColor];
}

+(void)setSelectedTitleColor:(UIColor *)selectedTitleColor
{
    NSData *selectedTitleColorData = [NSKeyedArchiver archivedDataWithRootObject:selectedTitleColor];
    [[NSUserDefaults standardUserDefaults] setObject:selectedTitleColorData forKey:SELECTED_TITLE_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getSelectedTitleColor
{
    NSData *selectedTitleColorData = [[NSUserDefaults standardUserDefaults] objectForKey:SELECTED_TITLE_COLOUR];
    UIColor *selectedTitleColor = [NSKeyedUnarchiver unarchiveObjectWithData:selectedTitleColorData];
    if(selectedTitleColor)
    {
        return selectedTitleColor;
    }
    return [UIColor colorWithRed:249.0/255.0 green:124.0/255.0 blue:43.0/255.0 alpha:1.0];
}

+(void)setSelectedLineColor:(UIColor *)selectedLineColor
{
    NSData *selectedLineColorData = [NSKeyedArchiver archivedDataWithRootObject:selectedLineColor];
    [[NSUserDefaults standardUserDefaults] setObject:selectedLineColorData forKey:SELECTED_LINE_COLOUR];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(UIColor *)getSelectedLineColor
{
    NSData *selectedLineColorData = [[NSUserDefaults standardUserDefaults] objectForKey:SELECTED_LINE_COLOUR];
    UIColor *selectedLineColor = [NSKeyedUnarchiver unarchiveObjectWithData:selectedLineColorData];
    if(selectedLineColor)
    {
        return selectedLineColor;
    }
    return [UIColor colorWithRed:249.0/255.0 green:124.0/255.0 blue:43.0/255.0 alpha:1.0];
}

+(void)setCardNumberErrorMessage:(NSString *)cardNumberErrorMessage
{
    NSData *cardNumberErrorMessageData = [NSKeyedArchiver archivedDataWithRootObject:cardNumberErrorMessage];
    [[NSUserDefaults standardUserDefaults] setObject:cardNumberErrorMessageData forKey:CARD_NUMBER_ERROR_MESSAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getCardNumberErrorMessage
{
    NSData *cardNumberErrorMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:CARD_NUMBER_ERROR_MESSAGE];
    NSString *cardNumberErrorMessage = [NSKeyedUnarchiver unarchiveObjectWithData:cardNumberErrorMessageData];
    if(cardNumberErrorMessage)
    {
        return cardNumberErrorMessage;
    }
    return @"Insert Card Number";
}

+(void)setCardNameErrorMessage:(NSString *)cardNameErrorMessage
{
    NSData *cardNameErrorMessageData = [NSKeyedArchiver archivedDataWithRootObject:cardNameErrorMessage];
    [[NSUserDefaults standardUserDefaults] setObject:cardNameErrorMessageData forKey:CARD_NAME_ERROR_MESSAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getCardNameErrorMessage
{
    NSData *cardNameErrorMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:CARD_NAME_ERROR_MESSAGE];
    NSString *cardNameErrorMessage = [NSKeyedUnarchiver unarchiveObjectWithData:cardNameErrorMessageData];
    if(cardNameErrorMessage)
    {
        return cardNameErrorMessage;
    }
    return @"Insert Name on Card";
}

+(void)setExpirationDateErrorMessage:(NSString *)expirationDateErrorMessage
{
    NSData *expirationDateErrorMessageData = [NSKeyedArchiver archivedDataWithRootObject:expirationDateErrorMessage];
    [[NSUserDefaults standardUserDefaults] setObject:expirationDateErrorMessageData forKey:EXPIRATION_DATE_ERROR_MESSAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getExpirationDateErrorMessage
{
    NSData *expirationDateErrorMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:EXPIRATION_DATE_ERROR_MESSAGE];
    NSString *expirationDateErrorMessage = [NSKeyedUnarchiver unarchiveObjectWithData:expirationDateErrorMessageData];
    if(expirationDateErrorMessage)
    {
        return expirationDateErrorMessage;
    }
    return @"Insert Expiration Date";
}

+(void)setCVCErrorMessage:(NSString *)cvcErrorMessage
{
    NSData *cvcErrorMessageData = [NSKeyedArchiver archivedDataWithRootObject:cvcErrorMessage];
    [[NSUserDefaults standardUserDefaults] setObject:cvcErrorMessageData forKey:CVC_ERROR_MESSAGE];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(NSString *)getCVCErrorMessage
{
    NSData *cvcErrorMessageData = [[NSUserDefaults standardUserDefaults] objectForKey:CVC_ERROR_MESSAGE];
    NSString *cvcErrorMessage = [NSKeyedUnarchiver unarchiveObjectWithData:cvcErrorMessageData];
    if(cvcErrorMessage)
    {
        return cvcErrorMessage;
    }
    return @"Insert CVC";
}

@end

//
//  StringUtils.h
//  everyPay_v3
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

NS_ASSUME_NONNULL_BEGIN

@interface StringUtils : NSObject

+ (NSString *)formatCreditCard:(NSString *)input;
+ (NSString *)formatCreditCardExpiry:(NSString *)input;
+ (NSString *)trimSpecialCharacters:(NSString *)input;
+ (NSDictionary *)nestedDictionaryByReplacingNullsWithNil:(NSDictionary*)sourceDictionary;
+ (void)addChildView:(UIViewController *)subView withParentView:(UIViewController *)viewParent;
+ (NSString *) datetimeToString:(NSDate *)date andDateFormat:(NSString *)dateFormat;
+ (NSString *) randomStringWithLength: (int) len;
+ (NSString *)returnStringNumber:(NSNumber *)number;
+ (void)setBorderView:(UIView *)view withColor:(UIColor *)color;
+ (void)showAlertViewToViewControllerWithTitle:(NSString *)title andMessage:(NSString *)message andTitleOKButton:(NSString *)titleOK andtitleCancelButton:(NSString *)titleCancel andConfirmAction:(void(^)(void))confirmBlock andCancelAction:(void(^)(void))cancelBlock;
+ (void)showLoading:(BOOL)isLoading withView:(UIViewController *)viewVC;

@end

NS_ASSUME_NONNULL_END

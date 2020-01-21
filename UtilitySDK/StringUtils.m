//
//  StringUtils.m
//  everyPay_v3
//


#import "StringUtils.h"

@implementation StringUtils

+ (NSString *)formatCreditCard:(NSString *)input
{
    input = [[self class] trimSpecialCharacters:input];
    NSString *output;
    switch (input.length) {
        case 1:
        case 2:
        case 3:
        case 4:
            output = [NSString stringWithFormat:@"%@", [input substringToIndex:input.length]];
            break;
        case 5:
        case 6:
        case 7:
        case 8:
            output = [NSString stringWithFormat:@"%@ %@", [input substringToIndex:4], [input substringFromIndex:4]];
            break;
        case 9:
        case 10:
        case 11:
        case 12:
            output = [NSString stringWithFormat:@"%@ %@ %@", [input substringToIndex:4], [input substringWithRange:NSMakeRange(4, 4)], [input substringFromIndex:8]];
            break;
        case 13:
        case 14:
        case 15:
        case 16:
            output = [NSString stringWithFormat:@"%@ %@ %@ %@", [input substringToIndex:4], [input substringWithRange:NSMakeRange(4, 4)], [input substringWithRange:NSMakeRange(8, 4)], [input substringFromIndex:12]];
            break;
        default:
            output = @"";
            break;
    }
    return output;
}

+ (NSString *)formatCreditCardExpiry:(NSString *)input
{
    input = [[self class] trimSpecialCharacters:input];
    NSString *output;
    switch (input.length) {
        case 1:
        case 2:
            output = [NSString stringWithFormat:@"%@", [input substringToIndex:input.length]];
            break;
        case 3:
        case 4:
            output = [NSString stringWithFormat:@"%@/%@", [input substringToIndex:2], [input substringFromIndex:2]];
            break;
        default:
            output = @"";
            break;
    }
    return output;
}

+ (NSString *)trimSpecialCharacters:(NSString *)input
{
    NSCharacterSet *special = [NSCharacterSet characterSetWithCharactersInString:@"/+-() "];
    return [[input componentsSeparatedByCharactersInSet:special] componentsJoinedByString:@""];
}

+ (NSDictionary *)nestedDictionaryByReplacingNullsWithNil:(NSDictionary*)sourceDictionary
{
    NSMutableDictionary *replaced = [NSMutableDictionary dictionaryWithDictionary:sourceDictionary];
    const id nul = [NSNull null];
    const NSString *blank = @"";
    [sourceDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id object, BOOL *stop) {
        object = [sourceDictionary objectForKey:key];
        if([object isKindOfClass:[NSDictionary class]]) {
            NSDictionary *innerDict = object;
            [replaced setObject:[self nestedDictionaryByReplacingNullsWithNil:innerDict] forKey:key];
            
        } else if([object isKindOfClass:[NSArray class]]){
            NSMutableArray *nullFreeRecords = [NSMutableArray array];
            for (id record in object) {
                
                if([record isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *nullFreeRecord = [self nestedDictionaryByReplacingNullsWithNil:record];
                    [nullFreeRecords addObject:nullFreeRecord];
                } else {
                    [nullFreeRecords addObject:record];
                }
            }
            [replaced setObject:nullFreeRecords forKey:key];
        } else {
            if(object == nul) {
                [replaced setObject:blank forKey:key];
            }
        }
    }];
    
    return [NSDictionary dictionaryWithDictionary:replaced];
}

+ (void)addChildView:(UIViewController *)subView withParentView:(UIViewController *)viewParent{
    [viewParent addChildViewController:subView];
    [subView.view setFrame:CGRectMake(0.0f, 0.0f, viewParent.view.frame.size.width, viewParent.view.frame.size.height)];
    [viewParent.view addSubview:subView.view];
    [subView didMoveToParentViewController:viewParent];
    
    subView.view.translatesAutoresizingMaskIntoConstraints = false;
    
    [subView.view.leadingAnchor constraintEqualToAnchor: viewParent.view.leadingAnchor].active = true;
    [subView.view.trailingAnchor constraintEqualToAnchor: viewParent.view.trailingAnchor].active = true;
    [subView.view.topAnchor constraintEqualToAnchor:viewParent.view.topAnchor].active = true;
    [subView.view.bottomAnchor constraintEqualToAnchor:viewParent.view.bottomAnchor].active = true;
    
}

+ (NSString *) datetimeToString:(NSDate *)date andDateFormat:(NSString *)dateFormat{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:dateFormat];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *) randomStringWithLength: (int) len {
    NSString *letters = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%C", [letters characterAtIndex: arc4random_uniform([letters length])]];
    }
    
    return randomString;
}

+ (NSString *)returnStringNumber:(NSNumber *)number {
    NSNumberFormatter *twoDecimalPlacesFormatter = [[NSNumberFormatter alloc] init];
    [twoDecimalPlacesFormatter setMinimumIntegerDigits:1];
    [twoDecimalPlacesFormatter setMaximumFractionDigits:2];
    [twoDecimalPlacesFormatter setMinimumFractionDigits:2];
    return [twoDecimalPlacesFormatter stringFromNumber:number];
}

+ (void)setBorderView:(UIView *)view withColor:(UIColor *)color{
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 5.f;
    view.layer.borderWidth = 1.f;
    view.layer.borderColor = color.CGColor;
}

+ (void)showAlertViewToViewControllerWithTitle:(NSString *)title andMessage:(NSString *)message andTitleOKButton:(NSString *)titleOK andtitleCancelButton:(NSString *)titleCancel andConfirmAction:(void(^)(void))confirmBlock andCancelAction:(void(^)(void))cancelBlock {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (cancelBlock) {
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:titleCancel
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction *action){
                                                                 //Close alertVC
                                                                 [alertVC dismissViewControllerAnimated:YES completion:nil];
                                                                 cancelBlock();
                                                             }];
        [alertVC addAction:cancelAction];
    }
    
    if (confirmBlock) {
        UIAlertAction *viewAction = [UIAlertAction actionWithTitle:titleOK
                                                             style:UIAlertActionStyleDefault
                                                           handler:^(UIAlertAction *action){
                                                               //Close alertVC
                                                               [alertVC dismissViewControllerAnimated:YES completion:nil];
                                                               confirmBlock();
                                                           }];
        [alertVC addAction:viewAction];
    }
    
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)showLoading:(BOOL)isLoading withView:(UIViewController *)viewVC {
    if (isLoading) {
        [MBProgressHUD hideHUDForView:viewVC.view animated:YES];
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:viewVC.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.backgroundView.backgroundColor = [UIColor colorWithRed:0.f/255.f green:0.f/255.f blue:0.f/255.f alpha:0.7];
    } else {
        [MBProgressHUD hideHUDForView:viewVC.view animated:YES];
    }
}

@end

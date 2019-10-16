//
//  CardPaymentViewController.m
//  everyPay_v2
//
//  Created by Duc.LT on 10/10/19.
//  Copyright © 2019 MobiLab. All rights reserved.
//

#import "CardPaymentViewController.h"

@interface CardPaymentViewController ()

@end

@implementation CardPaymentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    self.title = @"Every Pay";
    _lblHost.text = _host;
    
    [StringUtils setBorderView:_btnPay withColor:[UIColor clearColor]];
    _btnPay.backgroundColor = [UIColor colorWithRed:249.f/255.f green:124.f/255.f blue:43.f/255.f alpha:1.f];
    
    [_tfCardNumber addTarget:self action:@selector(creditCardNumberFormatter:) forControlEvents:UIControlEventEditingChanged];
    [_tfDate addTarget:self action:@selector(creditCardExpiryFormatter:) forControlEvents:UIControlEventEditingChanged];
    
    NSString *titleBtn = [NSString stringWithFormat:@"Pay %@%@",_currency,[StringUtils returnStringNumber:@([_amount integerValue])]];
    [_btnPay setTitle:titleBtn forState:UIControlStateNormal];
    
}

#pragma mark - Action Button
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickPay:(id)sender {
    [self.view endEditing:YES];
    NSString *cardNumber = [_tfCardNumber.text stringByReplacingOccurrencesOfString:@"-" withString:@""];
    NSString *name = _tfName.text;
    NSString *cvc = _tfCSC.text;
    NSString *month = @"";
    NSString *year = @"";
    NSArray *arrDate = [_tfDate.text componentsSeparatedByString:@"/"];
    if (arrDate.count > 0) {
        month = [arrDate objectAtIndex:0];
    }
    if (arrDate.count > 1) {
        year = [arrDate objectAtIndex:1];
    }
    _tfCardNumber.errorMessage = @"";
    _tfName.errorMessage = @"";
    _tfDate.errorMessage = @"";
    _tfCSC.errorMessage = @"";
    if (cardNumber.length < 16) {
        _tfCardNumber.errorMessage = @"Insert Card Number";
        return;
    }
    if (name.length == 0) {
        _tfName.errorMessage = @"Insert Name on Card";
        return;
    }
    if (_tfDate.text.length < 5) {
        _tfDate.errorMessage = @"Insert Expiration Date";
        return;
    }
    if ([month integerValue] > 12 || [month integerValue] <= 0) {
        _tfDate.errorMessage = @"Wrong Expiration Date";
        return;
    }
    if ([year integerValue] <= 0) {
        _tfDate.errorMessage = @"Wrong Expiration Date";
        return;
    }
    if (cvc.length < 3) {
        _tfCSC.errorMessage = @"Insert CVC";
        return;
    }
    [StringUtils showLoading:YES withView:self];
    [[PaymentAPI sharedInstance] callAPIPayment:cardNumber andName:name andMonth:month andYear:year andCVC:cvc andAPIUsername:_apiUsername andMobileToken:_mobile_access_token andHost:_host withCompletion:^(NSDictionary * _Nonnull dict) {
        [StringUtils showLoading:NO withView:self];
        if (dict && [dict objectForKey:@"payment_state"]) {
            NSString *state = [dict objectForKey:@"payment_state"];
            if ([state isEqualToString:@"settled"]
                || [state isEqualToString:@"completed"]
                || [state isEqualToString:@"authorised"]) {
                [self backBtn:nil];
                if (self.delegate && [self.delegate respondsToSelector:@selector(paymentSuccess)]) {
                    [self.delegate paymentSuccess];
                }
            } else if ([state containsString:@"waiting_for_3ds"]) {
                WebViewPayment *webview = [[WebViewPayment alloc] initWithNibName:@"WebViewPayment" bundle:nil];
                webview.urlPayment = self->_payment_link;
                webview.delegate = self->_target;
                [StringUtils addChildView:webview withParentView:self];
            } else {
                [self backBtn:nil];
                if (self.delegate && [self.delegate respondsToSelector:@selector(paymentFailure)]) {
                    [self.delegate paymentFailure];
                }
            }
        }
    } failureBlock:^(NSInteger failureCode, NSString * _Nonnull msgError) {
        [StringUtils showLoading:NO withView:self];
        [self backBtn:nil];
        if (self.delegate && [self.delegate respondsToSelector:@selector(paymentFailure)]) {
            [self.delegate paymentFailure];
        }
    }];
}

#pragma mark - UITextfield Delegate
- (void)creditCardNumberFormatter:(id)sender {
    NSString *formattedText = [StringUtils formatCreditCard:self.tfCardNumber.text]; // this is out formatter
    if (![formattedText isEqualToString:self.tfCardNumber.text]) {
        self.tfCardNumber.text = formattedText;
    }
}

- (void)creditCardExpiryFormatter:(id)sender {
    NSString *formattedText = [StringUtils formatCreditCardExpiry:self.tfDate.text];
    if (![formattedText isEqualToString:self.tfDate.text]) {
        self.tfDate.text = formattedText;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@""]) { // when backspace is hit
        return YES;
    }
    if (textField == self.tfCardNumber) {
        if (textField.text.length > 18)
            return NO;
    } else if (textField == self.tfDate) {
        if (textField.text.length > 4)
            return NO;
    } else if (textField == self.tfCSC) {
        if (textField.text.length > 2)
            return NO;
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

@end

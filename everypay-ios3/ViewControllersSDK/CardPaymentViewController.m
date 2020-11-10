//
//  CardPaymentViewController.m
//  everyPay_v3
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
    
    [self initLayout];
    
    self.title = @"Every Pay";
    _lblHost.text = _host;
    
    [_tfCardNumber addTarget:self action:@selector(creditCardNumberFormatter:) forControlEvents:UIControlEventEditingChanged];
    [_tfDate addTarget:self action:@selector(creditCardExpiryFormatter:) forControlEvents:UIControlEventEditingChanged];
    
    [StringUtils setBorderView:_btnPay withColor:[UIColor clearColor]];
    _btnPay.backgroundColor = [UIColor colorWithRed:249.f/255.f green:124.f/255.f blue:43.f/255.f alpha:1.f];
    NSString *titleBtn = [NSString stringWithFormat:@"Pay %@%@",_currency,[StringUtils returnStringNumber:@([_amount integerValue])]];
    [_btnPay setTitle:titleBtn forState:UIControlStateNormal];
    
}

- (void)initLayout {
    [_tfCardNumber setPlaceholderText:@"XXXX XXXX XXXX XXXX"];
    [_tfCardNumber setPlaceholderLabel:@"Card Number"];
    
    for (ACFloatingTextField *textfield in _textFieldCollection) {
        textfield.textColor = [SDKPaymentSettings getTextColor];
        textfield.placeHolderColor = [SDKPaymentSettings getPlaceholderColor];
        textfield.selectedPlaceHolderColor = [SDKPaymentSettings getTitleColor];
        textfield.selectedPlaceHolderTextfieldColor = [SDKPaymentSettings getPlaceholderColor];
        textfield.lineColor = [SDKPaymentSettings getLineColor];
        textfield.errorLineColor = [SDKPaymentSettings getLineErrorColor];
        textfield.errorTextColor = [SDKPaymentSettings getTextErrorColor];
        textfield.selectedLineColor = [SDKPaymentSettings getSelectedLineColor];
    }
}

#pragma mark - Action Button
- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)clickPay:(id)sender {
    [self.view endEditing:YES];
    NSString *cardNumber = [_tfCardNumber.text stringByReplacingOccurrencesOfString:@" " withString:@""];
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
    _tfCardNumber.errorText = @"";
    _tfName.errorText = @"";
    _tfDate.errorText = @"";
    _tfCSC.errorText = @"";
    if (cardNumber.length < 16) {
        _tfCardNumber.errorText = [SDKPaymentSettings getCardNumberErrorMessage];
        [_tfCardNumber showError];
        return;
    }
    if (name.length == 0) {
        _tfName.errorText = [SDKPaymentSettings getCardNameErrorMessage];
        [_tfName showError];
        return;
    }
    if (_tfDate.text.length < 5) {
        _tfDate.errorText = [SDKPaymentSettings getExpirationDateErrorMessage];
        [_tfDate showError];
        return;
    }
    if ([month integerValue] > 12 || [month integerValue] <= 0) {
        _tfDate.errorText = @"Wrong Expiration Date";
        [_tfDate showError];
        return;
    }
    if ([year integerValue] <= 0) {
        _tfDate.errorText = @"Wrong Expiration Date";
        [_tfDate showError];
        return;
    }
    if (cvc.length < 3) {
        _tfCSC.errorText = [SDKPaymentSettings getCVCErrorMessage];
        [_tfCSC showError];
        return;
    }
    [StringUtils showLoading:YES withView:self];
    [[PaymentAPI sharedInstance] callAPIPayment:cardNumber andName:name andMonth:month andYear:year andCVC:cvc andAPIUsername:_apiUsername andMobileToken:_mobile_access_token andHost:_host withCompletion:^(NSDictionary * _Nonnull dict) {
        NSDictionary *dictData = [StringUtils nestedDictionaryByReplacingNullsWithNil:dict];
        [StringUtils showLoading:NO withView:self];
        if (dictData && [dictData objectForKey:@"payment_state"]) {
            NSString *state = [dictData objectForKey:@"payment_state"];
            if (!state || [state isEqualToString:@""]) {
                return;
            } else if ([state isEqualToString:@"settled"]
                || [state isEqualToString:@"completed"]
                || [state isEqualToString:@"authorised"]) {
                [self backBtn:nil];
                if (self.delegate && [self.delegate respondsToSelector:@selector(paymentSuccess)]) {
                    [self.delegate paymentSuccess];
                }
            } else {
                NSBundle *bundle = [NSBundle bundleForClass:WebViewPayment.class];
                WebViewPayment *webview = [[WebViewPayment alloc] initWithNibName:@"WebViewPayment" bundle:bundle];
                webview.urlPayment = self->_payment_link;
                webview.delegate = self->_target;
                [StringUtils addChildView:webview withParentView:self];
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

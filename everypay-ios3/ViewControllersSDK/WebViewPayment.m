//
//  WebViewPayment.m
//  everyPay_v3
//


#import "WebViewPayment.h"

@interface WebViewPayment ()

@end

@implementation WebViewPayment

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backBtn:)];
    self.navigationItem.leftBarButtonItem = backBtn;
    
    self.title = @"Payment";
    
    _isCompleted = YES;
    _WKWebview = [self createNewWKWebView];
    _WKWebview.navigationDelegate = self;
    _WKWebview.UIDelegate = self;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_urlPayment]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:60.0];
    [_WKWebview loadRequest:request];
    [StringUtils showLoading:YES withView:self];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)backBtn:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Create WKWebView
- (WKWebView *)createNewWKWebView {
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    [wkUController addUserScript:wkUScript];
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    wkWebConfig.preferences.javaScriptCanOpenWindowsAutomatically = YES;
    wkWebConfig.preferences.javaScriptEnabled = YES;
    wkWebConfig.processPool = [[WKProcessPool alloc] init];
    
    WKWebView *previewWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) configuration:wkWebConfig];
    [self.view addSubview:previewWebView];
    [self.view bringSubviewToFront:previewWebView];
    [self setConstraintSubview:previewWebView andSuperView:self.view];
    return previewWebView;
}

- (void)setConstraintSubview:(UIView *)view andSuperView:(UIView *)superview {
    view.translatesAutoresizingMaskIntoConstraints = NO;
    /* Leading space to superview */
    NSLayoutConstraint *leftButtonXConstraint = [NSLayoutConstraint
                                                 constraintWithItem:view attribute:NSLayoutAttributeLeft
                                                 relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                 NSLayoutAttributeLeft multiplier:1.0 constant:0];
    /* Top space to superview Y*/
    NSLayoutConstraint *topButtonYConstraint = [NSLayoutConstraint
                                                constraintWithItem:view attribute:NSLayoutAttributeTop
                                                relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                NSLayoutAttributeTop multiplier:1.0f constant:0];
    /* Trailing space to superview Y*/
    NSLayoutConstraint *rightButtonXConstraint = [NSLayoutConstraint
                                                  constraintWithItem:view attribute:NSLayoutAttributeRight
                                                  relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                  NSLayoutAttributeRight multiplier:1.0f constant:0];
    
    /* Fixed Height */
    NSLayoutConstraint *bottomButtonXConstraint = [NSLayoutConstraint
                                                   constraintWithItem:view attribute:NSLayoutAttributeBottom
                                                   relatedBy:NSLayoutRelationEqual toItem:superview attribute:
                                                   NSLayoutAttributeBottom multiplier:1.0f constant:0];
    /* 4. Add the constraints to button's superview*/
    [superview addConstraints:@[leftButtonXConstraint, topButtonYConstraint, rightButtonXConstraint, bottomButtonXConstraint]];
}


#pragma mark - WKWebView Delegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    NSString *urlHost = [NSString stringWithFormat:@"%@?format=json",webView.URL.absoluteString];
    [StringUtils showLoading:YES withView:self];
    [[PaymentAPI sharedInstance] getDataFrom:urlHost withCompletion:^(NSDictionary * _Nonnull dict) {
        [StringUtils showLoading:NO withView:self];
        NSDictionary *dictData = [StringUtils nestedDictionaryByReplacingNullsWithNil:dict];
        if (dictData && [dictData objectForKey:@"state"]) {
            NSString *state = [dictData objectForKey:@"state"];
            if (!state || [state isEqualToString:@""]) {
                return;
            } else if ([state isEqualToString:@"settled"]
                       || [state isEqualToString:@"completed"]
                       || [state isEqualToString:@"authorized"]) {
                [webView stopLoading];
                if (self->_isCompleted) {
                    self->_isCompleted = NO;
                    [self backBtn:nil];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentSuccess)]) {
                        [self.delegate paymentSuccess];
                    }
                }
            } else if ([state isEqualToString:@"failed"]){
                [webView stopLoading];
                if (self->_isCompleted) {
                    self->_isCompleted = NO;
                    [self backBtn:nil];
                    if (self.delegate && [self.delegate respondsToSelector:@selector(paymentFailure)]) {
                        [self.delegate paymentFailure];
                    }
                }
            }
        }
    } failureBlock:^(NSInteger failureCode, NSString * _Nonnull msgError) {
        [StringUtils showLoading:NO withView:self];
    }];
    if (decisionHandler) {
        decisionHandler(WKNavigationResponsePolicyAllow);
    }
    
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if (decisionHandler) {
        decisionHandler(WKNavigationActionPolicyAllow);
    }
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * _Nullable credential))completionHandler {
    NSURLCredential * credential = [[NSURLCredential alloc] initWithTrust:[challenge protectionSpace].serverTrust];
    completionHandler(NSURLSessionAuthChallengeUseCredential, credential);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    if ([error.domain isEqualToString:NSURLErrorDomain]) {
        if(error.code == NSURLErrorTimedOut) {
            
        }
    }
}
@end

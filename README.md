# EveryPay iOS SDK


* [Overview](https://github.com/UnifiedPaymentSolutions/everypay-ios3#overview)
* [Requirements](https://github.com/UnifiedPaymentSolutions/everypay-ios3#requirements)
* [Integrating the SDK](https://github.com/UnifiedPaymentSolutions/everypay-ios3#integrating-the-sdk)
  * [Configure the SDK parameters](https://github.com/UnifiedPaymentSolutions/everypay-ios3#configure-the-sdk-parameters)
  * [Start payment of EveryPay](https://github.com/UnifiedPaymentSolutions/everypay-ios3#start_payment_of_everypay)
  * [How to integrate Payment Flow](https://github.com/UnifiedPaymentSolutions/everypay-ios3#how-to-integrate-payment)
* [Customising the card input form](https://github.com/UnifiedPaymentSolutions/everypay-ios3#customising-the-card-input-form)

## Overview
From EveryPay SDK has two payment flows:

1. Alternative Payment Method (APM) Flow<br/>
On Card Payment's screen, a full-screen WebView is opened and the associated payment_link is opened inside this WebView<br/>
2. Card Payment Flow<br/>
APM screen presents a preconfigured Card Details form and user have to enter the information of user card to perform payment.


**NB!** You have to add following item to your Info.plist file, in order for SDK to work. Otherwise ATS will complain about TLS handshake :
```xml
    <key>NSAppTransportSecurity</key>
        <dict>
            <key>NSAllowsArbitraryLoads</key>
                <true/>
        </dict>
```
## Requirements

iOS 8 or later is required for NSURLSession that is used in everyPay SDK.

## Integrating the SDK

### Manually

Add folder sdk to your project and include SDKPaymentKit.h where needed.

### Using CocoaPods

Add 'everyPay_v3-ios' to podfile and include SDKPaymentKit.h where needed.

### Configure the SDK parameters

Modify kAPIUserName , kAPISecret,  kBaseURL  and kToken in APIConnect.h to your needs.

```objectivec
static NSString *const kAPIUserName = YOUR_USER_NAME;
static NSString *const kAPISecret = YOUR_PASSWORD;
static NSString *const kBaseURL = YOUR_URL;
static NSString *const kToken = YOUR_TOKEN;
```
### Start payment of EveryPay 

```
NSString *host = @"https://igw-demo.every-pay.com"; // get from Setting page
NSString *apiUsername = @"7a40a7d7e0b9b13d";  //get from API
NSString *mobileToken = @"2589e754dbaada212901039c7a08275e84777c42"; //get from API
NSString *currency = @"EUR"; //get from API
NSString *paymentLink = @"https://igw-demo.every-pay.com/lp/76c78d/fofrnq?method_source=card"; //get from API
NSString *amount = @"10"; //get from API
NSString *paymentType = @"card"; //get from API

SDKPaymentKit *sdkPayment = [SDKPaymentKit initWithUserName:apiUsername andHost:host andAmount:amount andCurrency:currency];
[sdkPayment paymentWithMobileToken:mobileToken andPaymentLink:paymentLink andPaymentType:paymentType andDelegate:self];

```

**NOTE: EveryPay object initialization changed as of version 3.0.0. First you need to call [SDKPaymentKit initWithUserName:apiUsername andHost:host andAmount:amount andCurrency:currency];**

Create a new EveryPay object, for example in your payment:

```objectivec
SDKPaymentKit *sdkPayment = [SDKPaymentKit initWithUserName:apiUsername andHost:host andAmount:amount andCurrency:currency];
```
apiUsername is the username of the Merchant.<br/>
host is the host of Everypay GW i.e igw-demo.every-pay.com/ <br/>
amount is the transaction amount, use decimal number with 2 digit precision, e.g. 10.55 <br/>
currency is the currency of processing account <br/>

### How to integrate Payment Flow

When the user is ready to start and already configure SDK through initv3 method, we can start payment flow by:
```objectivec
[sdkPayment paymentWithMobileToken:mobileToken andPaymentLink:paymentLink andPaymentType:paymentType andDelegate:self];
```
paymentLink is the payment link.<br/>
paymentType is type of payment flow.<br/>
mobileToken is the token only use in Card Payment Flow.<br/>
This SDK has two payment flows:

1. ```Card Payment Flow``` if method_source is ```card```.
```objectivec
[sdkPayment paymentWithMobileToken:mobileToken andPaymentLink:paymentLink andPaymentType:@"card" andDelegate:self];
```
2. ```Alternative Payment Method (APM) Flow``` if method_source is not ```card```, e.g: bank

```objectivec
[sdkPayment paymentWithMobileToken:@"" andPaymentLink:paymentLink andPaymentType:@"bank" andDelegate:self];
```

**Result**
Success delegate  `paymentSuccess`  called when payment success
```objectivec
- (void)paymentSuccess {
    NSLog(@"SUCCESS");
}
```
If fail it will call failure delegate  `paymentFailure` 
```objectivec
- (void)paymentFailure {
    NSLog(@"FAILURE");
}

```

## Customising the card input form

If the EveryPay card input form does not match your requirements, or if you wish to add custom branding beyond the configuration options, then you can create a custom one. There are two requirements for a custom card form:

* It should construct a [SDKPaymentSettings](https://github.com/UnifiedPaymentSolutions/everypay-ios3/blob/master/everyPay/everyPayv3/SDKPayment/UtilitySDK.h).
* You can call this function for custom card 
```objectivec
- (void)everyPayCardSettings {
    [SDKPaymentSettings setTitleColor:[UIColor redColor]];
    [SDKPaymentSettings setLineColor:[UIColor redColor]];
    ...
}

```



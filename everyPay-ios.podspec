#
#  Be sure to run `pod spec lint everyPay-ios3.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.name         = "everyPay-ios"
  spec.version      = "3.3.0"
  spec.summary      = "iOS SDK for EveryPay service"
  spec.description  = <<-DESC
                   EveryPay SDK for iOS allows merchants to easily integrate EveryPay payment flow into applications.
                   Check homepage for sample usage.
                   DESC

  spec.homepage     = "https://github.com/UnifiedPaymentSolutions/everypay-ios3"
  spec.license      = "Apache License, Version 2.0"

  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.author             = { "EveryPay" => "support@every-pay.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.platform     = :ios, "9.0"

  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source       = { :git => "https://github.com/UnifiedPaymentSolutions/everypay-ios3.git", :tag => "#{spec.version}" }

  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.source_files  = "*.{h,m,swift}", "UtilitySDK", "UtilitySDK/**/*.{h,m,swift}", "ViewControllersSDK/*.{h,m,swift}"

  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  spec.resource  = "ViewControllersSDK/*.{xib}"
end

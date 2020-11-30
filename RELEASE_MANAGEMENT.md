# Update Version

1. update `everyPay-ios.podspec` file
    * The `spec.version` string
2. Tag git commit with specified version 

# Verify POD

Note: below `pod spec lint` command will fail if the git tag is not yet pushed:

```
pod spec lint everyPay-ios.podspec
pod lib lint --allow-warnings
```

# Publish POD to CocoaPods trunk

```
pod trunk push
```

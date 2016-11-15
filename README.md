# FSLogger

[![CI Status](http://img.shields.io/travis/王正一/FSLogger.svg?style=flat)](https://travis-ci.org/王正一/FSLogger)
[![Version](https://img.shields.io/cocoapods/v/FSLogger.svg?style=flat)](http://cocoapods.org/pods/FSLogger)
[![License](https://img.shields.io/cocoapods/l/FSLogger.svg?style=flat)](http://cocoapods.org/pods/FSLogger)
[![Platform](https://img.shields.io/cocoapods/p/FSLogger.svg?style=flat)](http://cocoapods.org/pods/FSLogger)

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

FSLogger is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "FSLogger"
```

## Usage
```Swift
// 默认输出等级为全部输出:
Fs("哈哈哈")
FsInfo("嘻嘻")
FsWarn("嘿嘿")
FsError("错啦!!!")
// outPut:
// <⚪️Verbose⚪️>Tests.testExample()[20]哈哈哈
// <🎾  Info 🎾>Tests.testExample()[21]嘻嘻
// <⚠️Warning⚠️>Tests.testExample()[22]嘿嘿
// <‼️ Error ‼️>Tests.testExample()[23]错啦!!!
// 可以设置输出等级,低于此等级的log会被屏蔽:
FSLog.logLevelShown = .warnning
Fs("哈哈哈")
FsInfo("嘻嘻")
FsWarn("嘿嘿")
FsError("错啦!!!")
// outPut:
// <⚠️Warning⚠️>Tests.testExample()[27]嘿嘿
// <‼️ Error ‼️>Tests.testExample()[28]错啦!!!
```


## Author

王正一, wangzhengyi@qufenqi.com

## License

FSLogger is available under the MIT license. See the LICENSE file for more info.

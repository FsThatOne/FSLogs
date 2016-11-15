#
# Be sure to run `pod lib lint FSLogger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "FSLogger"
  s.version          = "0.1.3"
  s.summary          = "A log tool in Swift."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                         1.支持分级输出,可自定义最低输出等级(Info,Warn,Error,All)
                         2.彩色输出
                         3.输出日志文件到应用沙盒,必要时可查看日志
                         4.开关控制输出与否
                     DESC

  s.homepage         = "https://github.com/FsThatOne/FSLogs"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "王正一" => "fsymbio@icloud.com" }
  s.source           = { :git => "https://github.com/FsThatOne/FSLogs.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'FSLogger/Classes/**/*'
  # s.resource_bundles = {
  #   'FSLogger' => ['FSLogger/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

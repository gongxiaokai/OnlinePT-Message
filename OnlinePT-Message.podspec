#
# Be sure to run `pod lib lint OnlinePT-Message.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OnlinePT-Message'
  s.version          = '0.0.1'
  s.summary          = '组件化 - 消息模块'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/gongxiaokai/OnlinePT-Message'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gongxiaokai' => '139391025@qq.com' }
  s.source           = { :git => 'https://github.com/gongxiaokai/OnlinePT-Message.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'

  s.source_files = 'OnlinePT-Message/Classes/**/*'
  
  s.resource_bundles = {
      'OnlinePT-Message' => ['OnlinePT-Message/Assets/**/*']
  }
  s.static_framework = true
  s.frameworks = 'UIKit'
  s.dependency 'OnlinePT-BaseCore'  , '~> 0.0.1'
  s.dependency 'OnlinePT-Config'    , '~> 0.0.1'
end

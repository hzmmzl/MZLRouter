#
# Be sure to run `pod lib lint MZLRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MZLRouter'
  s.version          = '0.1.1'
  s.summary          = '一个路由'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/hzmmzl/MZLRouter'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'minzhaolin' => '2736652044@qq.com' }
  s.source           = { :git => 'https://github.com/hzmmzl/MZLRouter.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

#  还有如果使用subspec，就不需要描述整个文件夹路径，会造成subspec划分的文件夹没有代码
#  s.source_files = 'MZLRouter/Classes/**/*'
  
   s.resource_bundles = {
     'MZLRouter' => ['MZLRouter/Assets/*']
   }
   

   s.subspec 'URLRouter' do |router|
     router.ios.deployment_target = '9.0'
     router.source_files = 'MZLRouter/Classes/URLRouter/**/*'
   end

   s.subspec 'TargetActionRouter' do |router|
     router.ios.deployment_target = '9.0'
     router.source_files = 'MZLRouter/Classes/TargetActionRouter/**/*'
   end

   s.subspec 'Helper' do |helper|
     helper.ios.deployment_target = '9.0'
     helper.source_files = 'MZLRouter/Classes/Helper/**/*'
   end
   
   # pch文件位置
   #s.prefix_header_file = 'MZLRouter/Classes/include/MZLRouterPods-Prefix.pch'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

#
# Be sure to run `pod lib lint MagicScreenView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MagicScreenView'
  s.version          = '0.1.0'
  s.summary          = 'The simpliest way to create MVP functionality.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'MagicScreenView helps developers to create MVP functionality as simply as possible.'

  s.homepage         = 'https://github.com/OBRIO-Team/MagicScreenView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SerhiiMatvieiev' => 'serhii.matvieiev@gen.tech' }
  s.source           = { :git => 'https://github.com/OBRIO-Team/MagicScreenView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.swift_version = '5.0'
  
  s.ios.deployment_target = '11.0'

  s.source_files = 'MagicScreenView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MagicScreenView' => ['MagicScreenView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

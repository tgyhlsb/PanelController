#
# Be sure to run `pod lib lint PanelController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "PanelController"
  s.version          = "1.0.12"
  s.summary          = "Controller component to add panels on both side of the screen."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  # s.description      = <<-DESC

  s.homepage         = "https://github.com/tgyhlsb/PanelController"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Tanguy Helesbeux" => "pods@helesbeux.com" }
  s.source           = { :git => "https://github.com/tgyhlsb/PanelController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/tgyhlsb'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PanelController/Classes/**/*'
  s.resource_bundles = {
#   'PanelController' => ['PanelController/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end

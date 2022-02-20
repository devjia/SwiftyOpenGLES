#
# Be sure to run `pod lib lint SwiftyOpenGLES.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftyOpenGLES'
  s.version          = '1.0'
  s.summary          = 'OpenGLES Render Engine With Swift'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC
  s.homepage         = 'https://github.com/devjia/SwiftyOpenGLES'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'devjia' => 'devjia2@gmail.com' }
  s.source           = { :git => 'https://github.com/devjia/SwiftyOpenGLES.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'Sources/**/*.swift'
  s.frameworks = 'UIKit', 'GLKit'
end

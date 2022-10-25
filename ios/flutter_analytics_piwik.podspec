#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint flutter_analytics_piwik.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'flutter_analytics_piwik'
  s.version          = '1.0.3'
  s.summary          = 'Alternative package for Piwik SDK'
  s.description      = <<-DESC
A new Flutter project.
                       DESC
  s.homepage         = 'https://github.com/NonowPoney/flutter_analytics_piwik'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'bruno.drean@gmail.com' }
  s.source           = { :git => 'https://github.com/NonowPoney/flutter_analytics_piwik.git' }
  s.source_files = 'Classes/**/*'
  s.static_framework = true
  s.dependency 'Flutter'
  s.dependency 'PiwikPROSDK', '~> 1.1.3'
  s.platform = :ios, '9.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end

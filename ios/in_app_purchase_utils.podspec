#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint in_app_purchase_utils.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'in_app_purchase_utils'
  s.version          = '0.0.1'
  s.summary          = 'iOS in-app purchase utilities for Flutter.'
  s.description      = <<-DESC
Flutter plugin exposing iOS StoreKit utilities such as AppStore.showManageSubscriptions.
                       DESC
  s.homepage         = 'https://kagi.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Kagi' => 'support@kagi.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'

  # If your plugin requires a privacy manifest, for example if it uses any
  # required reason APIs, update the PrivacyInfo.xcprivacy file to describe your
  # plugin's privacy impact, and then uncomment this line. For more information,
  # see https://developer.apple.com/documentation/bundleresources/privacy_manifest_files
  # s.resource_bundles = {'in_app_purchase_utils_privacy' => ['Resources/PrivacyInfo.xcprivacy']}
end

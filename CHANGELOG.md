## 0.0.2

* Adds Swift Package Manager support for iOS. The plugin now ships a
  `Package.swift`, while the `.podspec` is retained so both Swift Package
  Manager and CocoaPods consumers keep working.
* Migrates the Android build to built-in Kotlin. The Kotlin Gradle Plugin is now
  applied only on Android Gradle Plugin (AGP) versions below 9, keeping the
  plugin compatible with both AGP 8 and the built-in Kotlin support in AGP 9+.

## 0.0.1

* Initial release.
* `showManageSubscriptions({String? sku})`:
  * iOS 15+: wraps `AppStore.showManageSubscriptions(in:)`.
  * iOS 13–14: opens `https://apps.apple.com/account/subscriptions` in Safari.
  * Android: launches an `ACTION_VIEW` intent for the Play Store
    subscriptions deep link, optionally targeting a specific SKU.

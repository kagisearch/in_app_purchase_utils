## 0.0.1

* Initial release.
* `showManageSubscriptions({String? sku})`:
  * iOS 15+: wraps `AppStore.showManageSubscriptions(in:)`.
  * iOS 13–14: opens `https://apps.apple.com/account/subscriptions` in Safari.
  * Android: launches an `ACTION_VIEW` intent for the Play Store
    subscriptions deep link, optionally targeting a specific SKU.

# in_app_purchase_utils

Flutter plugin for opening the system "manage subscriptions" UI on both
iOS (StoreKit) and Android (Google Play).

## Usage

```dart
import 'package:flutter/services.dart';
import 'package:in_app_purchase_utils/in_app_purchase_utils.dart';

final iap = InAppPurchaseUtils();

try {
  // Open the full subscriptions list.
  await iap.showManageSubscriptions();

  // Or, on Android, jump straight to a specific subscription product.
  await iap.showManageSubscriptions(sku: 'monthly_pro');
} on PlatformException catch (e) {
  debugPrint('Failed to open manage subscriptions: ${e.code} ${e.message}');
}
```

## Behavior

### iOS

* iOS 15+: presents the system manage-subscriptions sheet via
  `AppStore.showManageSubscriptions(in: scene)` on the active foreground
  `UIWindowScene`.
* iOS 13–14: opens `https://apps.apple.com/account/subscriptions` in
  Safari.
* The `sku` argument is ignored on iOS.

Possible error codes: `NO_SCENE`, `STOREKIT_ERROR`, `INVALID_URL`.

### Android

Launches an `ACTION_VIEW` intent for the Play Store subscriptions deep
link:

* No `sku`: `https://play.google.com/store/account/subscriptions`
* With `sku`: `https://play.google.com/store/account/subscriptions?sku=<sku>&package=<applicationId>`

Possible error codes: `NO_HANDLER` (no activity can resolve the intent —
typically a device without Play Services), `INTENT_ERROR`.

## Requirements

* iOS deployment target: 13.0
* Android `minSdk`: 24
* Flutter: 3.3.0+

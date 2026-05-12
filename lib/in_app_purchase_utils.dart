import 'in_app_purchase_utils_platform_interface.dart';

class InAppPurchaseUtils {
  Future<String?> getPlatformVersion() {
    return InAppPurchaseUtilsPlatform.instance.getPlatformVersion();
  }

  /// Presents the system "manage subscriptions" UI.
  ///
  /// * **iOS 15+**: opens `AppStore.showManageSubscriptions(in:)` on the
  ///   foreground window scene. The [sku] argument is ignored.
  /// * **iOS 13–14**: opens `https://apps.apple.com/account/subscriptions`
  ///   in Safari. The [sku] argument is ignored.
  /// * **Android**: opens the Google Play subscriptions deep link. If [sku]
  ///   is provided, it targets the specific subscription product
  ///   (`?sku=<sku>&package=<applicationId>`); otherwise the user lands on
  ///   the full subscriptions list.
  ///
  /// Throws a [PlatformException] if the platform cannot present the UI
  /// (e.g. no active scene on iOS, no activity available on Android).
  Future<void> showManageSubscriptions({String? sku}) {
    return InAppPurchaseUtilsPlatform.instance.showManageSubscriptions(sku: sku);
  }
}

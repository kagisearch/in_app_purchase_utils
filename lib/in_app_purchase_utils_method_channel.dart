import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'in_app_purchase_utils_platform_interface.dart';

/// An implementation of [InAppPurchaseUtilsPlatform] that uses method channels.
class MethodChannelInAppPurchaseUtils extends InAppPurchaseUtilsPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('in_app_purchase_utils');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<void> showManageSubscriptions({String? sku}) async {
    await methodChannel.invokeMethod<void>(
      'showManageSubscriptions',
      <String, Object?>{'sku': sku},
    );
  }
}

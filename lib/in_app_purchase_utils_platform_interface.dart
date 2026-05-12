import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'in_app_purchase_utils_method_channel.dart';

abstract class InAppPurchaseUtilsPlatform extends PlatformInterface {
  /// Constructs a InAppPurchaseUtilsPlatform.
  InAppPurchaseUtilsPlatform() : super(token: _token);

  static final Object _token = Object();

  static InAppPurchaseUtilsPlatform _instance = MethodChannelInAppPurchaseUtils();

  /// The default instance of [InAppPurchaseUtilsPlatform] to use.
  ///
  /// Defaults to [MethodChannelInAppPurchaseUtils].
  static InAppPurchaseUtilsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [InAppPurchaseUtilsPlatform] when
  /// they register themselves.
  static set instance(InAppPurchaseUtilsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> showManageSubscriptions({String? sku}) {
    throw UnimplementedError('showManageSubscriptions() has not been implemented.');
  }
}

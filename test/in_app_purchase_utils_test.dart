import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_utils/in_app_purchase_utils.dart';
import 'package:in_app_purchase_utils/in_app_purchase_utils_platform_interface.dart';
import 'package:in_app_purchase_utils/in_app_purchase_utils_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockInAppPurchaseUtilsPlatform
    with MockPlatformInterfaceMixin
    implements InAppPurchaseUtilsPlatform {
  final List<String?> showManageSubscriptionsCalls = <String?>[];

  @override
  Future<String?> getPlatformVersion() => Future.value('42');

  @override
  Future<void> showManageSubscriptions({String? sku}) async {
    showManageSubscriptionsCalls.add(sku);
  }
}

void main() {
  final InAppPurchaseUtilsPlatform initialPlatform = InAppPurchaseUtilsPlatform.instance;

  test('$MethodChannelInAppPurchaseUtils is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelInAppPurchaseUtils>());
  });

  test('getPlatformVersion', () async {
    InAppPurchaseUtils inAppPurchaseUtilsPlugin = InAppPurchaseUtils();
    MockInAppPurchaseUtilsPlatform fakePlatform = MockInAppPurchaseUtilsPlatform();
    InAppPurchaseUtilsPlatform.instance = fakePlatform;

    expect(await inAppPurchaseUtilsPlugin.getPlatformVersion(), '42');
  });

  test('showManageSubscriptions delegates to platform', () async {
    final plugin = InAppPurchaseUtils();
    final fakePlatform = MockInAppPurchaseUtilsPlatform();
    InAppPurchaseUtilsPlatform.instance = fakePlatform;

    await plugin.showManageSubscriptions();
    await plugin.showManageSubscriptions(sku: 'monthly_pro');

    expect(fakePlatform.showManageSubscriptionsCalls, [null, 'monthly_pro']);
  });
}

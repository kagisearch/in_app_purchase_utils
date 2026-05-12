import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:in_app_purchase_utils/in_app_purchase_utils_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelInAppPurchaseUtils platform = MethodChannelInAppPurchaseUtils();
  const MethodChannel channel = MethodChannel('in_app_purchase_utils');
  final List<MethodCall> log = <MethodCall>[];

  setUp(() {
    log.clear();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          log.add(methodCall);
          if (methodCall.method == 'getPlatformVersion') {
            return '42';
          }
          return null;
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });

  test('showManageSubscriptions invokes channel with null sku by default', () async {
    await platform.showManageSubscriptions();
    expect(log, hasLength(1));
    expect(log.single.method, 'showManageSubscriptions');
    expect(log.single.arguments, {'sku': null});
  });

  test('showManageSubscriptions forwards sku', () async {
    await platform.showManageSubscriptions(sku: 'yearly_pro');
    expect(log.single.arguments, {'sku': 'yearly_pro'});
  });
}

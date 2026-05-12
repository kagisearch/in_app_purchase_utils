import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:in_app_purchase_utils/in_app_purchase_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  String _status = '';
  final _inAppPurchaseUtilsPlugin = InAppPurchaseUtils();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion =
          await _inAppPurchaseUtilsPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> _showManageSubscriptions({String? sku}) async {
    setState(() => _status = 'Opening manage subscriptions${sku == null ? '' : ' for $sku'}…');
    try {
      await _inAppPurchaseUtilsPlugin.showManageSubscriptions(sku: sku);
      if (!mounted) return;
      setState(() => _status = 'Launched.');
    } on PlatformException catch (e) {
      if (!mounted) return;
      setState(() => _status = 'Error: ${e.code} ${e.message ?? ''}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              ElevatedButton(
                onPressed: () => _showManageSubscriptions(),
                child: const Text('Manage subscriptions'),
              ),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () => _showManageSubscriptions(sku: 'monthly_pro'),
                child: const Text('Manage "monthly_pro" (Android)'),
              ),
              const SizedBox(height: 16),
              Text(_status),
            ],
          ),
        ),
      ),
    );
  }
}

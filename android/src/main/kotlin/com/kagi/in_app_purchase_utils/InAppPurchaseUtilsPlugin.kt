package com.kagi.in_app_purchase_utils

import android.app.Activity
import android.content.ActivityNotFoundException
import android.content.Context
import android.content.Intent
import android.net.Uri
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class InAppPurchaseUtilsPlugin :
    FlutterPlugin,
    ActivityAware,
    MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context
    private var activity: Activity? = null

    override fun onAttachedToEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        applicationContext = binding.applicationContext
        channel = MethodChannel(binding.binaryMessenger, "in_app_purchase_utils")
        channel.setMethodCallHandler(this)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivity() {
        activity = null
    }

    override fun onDetachedFromActivityForConfigChanges() {
        activity = null
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPlatformVersion" ->
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            "showManageSubscriptions" ->
                showManageSubscriptions(call.argument<String?>("sku"), result)
            else -> result.notImplemented()
        }
    }

    private fun showManageSubscriptions(sku: String?, result: Result) {
        val packageName = applicationContext.packageName
        val uri = if (sku.isNullOrBlank()) {
            Uri.parse("https://play.google.com/store/account/subscriptions")
        } else {
            Uri.parse(
                "https://play.google.com/store/account/subscriptions" +
                    "?sku=${Uri.encode(sku)}&package=${Uri.encode(packageName)}"
            )
        }

        val intent = Intent(Intent.ACTION_VIEW, uri).apply {
            if (activity == null) addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        val launcher: Context = activity ?: applicationContext
        try {
            launcher.startActivity(intent)
            result.success(null)
        } catch (e: ActivityNotFoundException) {
            result.error(
                "NO_HANDLER",
                "No activity available to handle the Play Store subscriptions intent.",
                e.localizedMessage,
            )
        } catch (e: SecurityException) {
            result.error(
                "INTENT_ERROR",
                e.localizedMessage ?: "SecurityException starting subscriptions intent.",
                null,
            )
        }
    }
}

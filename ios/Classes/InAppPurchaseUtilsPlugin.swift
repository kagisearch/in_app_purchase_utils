import Flutter
import StoreKit
import UIKit

public class InAppPurchaseUtilsPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "in_app_purchase_utils",
      binaryMessenger: registrar.messenger()
    )
    let instance = InAppPurchaseUtilsPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("iOS " + UIDevice.current.systemVersion)
    case "showManageSubscriptions":
      showManageSubscriptions(result: result)
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func showManageSubscriptions(result: @escaping FlutterResult) {
    if #available(iOS 15.0, *) {
      Task { @MainActor in
        guard
          let scene = UIApplication.shared.connectedScenes
            .first(where: { $0.activationState == .foregroundActive })
            as? UIWindowScene
        else {
          result(
            FlutterError(
              code: "NO_SCENE",
              message: "No active foreground window scene",
              details: nil
            )
          )
          return
        }

        do {
          try await AppStore.showManageSubscriptions(in: scene)
          result(nil)
        } catch {
          result(
            FlutterError(
              code: "STOREKIT_ERROR",
              message: error.localizedDescription,
              details: nil
            )
          )
        }
      }
    } else {
      guard let url = URL(string: "https://apps.apple.com/account/subscriptions") else {
        result(
          FlutterError(
            code: "INVALID_URL",
            message: "Could not build fallback subscriptions URL",
            details: nil
          )
        )
        return
      }
      UIApplication.shared.open(url, options: [:]) { _ in
        result(nil)
      }
    }
  }
}

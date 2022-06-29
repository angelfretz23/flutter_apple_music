import Flutter
import StoreKit

public class AppleMusicInfo: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: PLUGIN_PATH + "/methods", binaryMessenger: registrar.messenger())
    let instance = AppleMusicInfo()
    registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Methods.storefrontCountryCode:
            getStorefrontCountryCode(result: result)
        case Methods.storefrontIdentifier:
            getStorefrontIdentifier(result: result)
        case Methods.permissions:
            requestPermissions(result: result)
        case Methods.userToken:
            if let devToken = (call.arguments as? [String: String])?["developerToken"] {
                getUserTokenWith(developerToken: devToken, result: result)
            }
        default:
            result(FlutterError(code: "Invalid Method", message: "Method \(call.method) is not supported", details: nil))
        }
    }
    
    private func requestPermissions(result: @escaping FlutterResult) {
        SKCloudServiceController.requestAuthorization { status in
            let authorizationValue = status.rawValue
            result(authorizationValue)
        }
    }
    
    private func getStorefrontCountryCode(result: @escaping FlutterResult) {
        SKCloudServiceController().requestStorefrontCountryCode { [weak self] code, error in
            
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.handleError(error: error, result: result)
                return
            }
            
            if let code = code {
              result(code)
            }
        }
    }
    
    private func getStorefrontIdentifier(result: @escaping FlutterResult) {
        SKCloudServiceController().requestStorefrontIdentifier { [weak self] identifier, error in
            
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.handleError(error: error, result: result)
                return
            }
            
            if let identifier = identifier {
              result(identifier)
            }
        }
    }
    
    private func getUserTokenWith(developerToken: String, result: @escaping FlutterResult) {
        SKCloudServiceController().requestUserToken(forDeveloperToken: developerToken) { [weak self] userToken, error in
            
            guard let strongSelf = self else { return }
            
            if let error = error {
                strongSelf.handleError(error: error, result: result)
                return
            }
            
            result(userToken)
        }
    }
    
    private func handleError(error: Error, result: @escaping FlutterResult) {
        if let skerror = error as? SKError {
            result(FlutterError(code: "\(skerror.code)", message: skerror.localizedDescription, details: nil))
            return
        }
        
        result(FlutterError(code: "ERROR", message: error.localizedDescription, details: nil))
    }
}

import Flutter
import UIKit
import Castle
import Castle.CastleConfiguration

public class SwiftCastleFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "castle", binaryMessenger: registrar.messenger())
    let instance = SwiftCastleFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
        case "configure":
            configure(call, result: result)
        case "configureWithPublishableKey":
            configureWithPublishableKey(call, result: result)
        case "identify":
            identify(call, result: result)
        case "secure":
            secure(call, result: result)
        case "screen":
            screen(call, result: result)
        case "flush":
            flush(call, result: result)
        case "flushIfNeeded":
            flushIfNeeded(call, result: result)
        case "reset":
            reset(call, result: result)
        case "baseUrl":
            baseUrl(call, result: result)
        case "clientId":
            clientId(call, result: result)
        case "clientIdHeaderName":
            clientIdHeaderName(call, result: result)
        case "userId":
            userId(call, result: result)
        case "userSignature":
            userSignature(call, result: result)
        case "userAgent":
            userAgent(call, result: result)
        case "queueSize":
            queueSize(call, result: result)
        default:
            result(FlutterMethodNotImplemented)
    }
  }
    
    private func configure(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
    }
    
    private func configureWithPublishableKey(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any> {
            let configuration = CastleConfiguration(publishableKey: (args["publishableKey"] as? String)!)
            configuration.isDebugLoggingEnabled = (args["debugLoggingEnabled"] as? Bool)!
            configuration.flushLimit = (args["flushLimit"] as? UInt)!
            configuration.maxQueueLimit = (args["maxQueueLimit"] as? UInt)!

            Castle.configure(configuration)
            
            result(true)
        } else {
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
        }
    }
    
    private func identify(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any> {
            Castle.identify((args["userId"] as? String)!)
            
            result(true)
        } else {
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
        }
    }
    
    private func secure(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any> {
            Castle.secure((args["signature"] as? String)!)
            
            result(true)
        } else {
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
        }
    }
    
    private func screen(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any> {
            Castle.screen((args["name"] as? String)!)
            
            result(true)
        } else {
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
        }
    }
    
    private func flush(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        Castle.flush()
        
        result(true)
    }
    
    private func flushIfNeeded(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if let args = call.arguments as? Dictionary<String, Any> {
            Castle.flushIfNeeded(URL(string: (args["url"] as? String)!)!)
            
            result(true)
        } else {
            result(FlutterError.init(code: "bad args", message: nil, details: nil))
        }
    }
    
    private func reset(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        Castle.reset()
        
        result(true)
    }
    
    private func baseUrl(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(Castle.baseURL())
    }
    
    private func clientId(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(Castle.clientId())
    }
    
    private func clientIdHeaderName(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(CastleClientIdHeaderName)
    }
    
    private func userId(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(Castle.userId())
    }
    
    private func userSignature(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(Castle.userSignature())
    }
    
    private func userAgent(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(Castle.userAgent())
    }
    
    private func queueSize(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        result(Castle.queueSize())
    }
}
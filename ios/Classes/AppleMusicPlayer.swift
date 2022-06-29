//
//  AppleMusicPlayer.swift
//  flutter_apple_music
//
//  Created by Angel Contreras on 6/6/22.
//

import Flutter
import MediaPlayer

public class AppleMusicPlayer: NSObject, FlutterPlugin {
    var player: MPMusicPlayerController!
    
    static let instance = AppleMusicPlayer()
    
    public override init() {
        super.init()
        player = MPMusicPlayerController.applicationMusicPlayer
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: PLUGIN_PATH + "/musicplayer", binaryMessenger: registrar.messenger())
        let instance = AppleMusicPlayer.instance
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Methods.setQueue:
            setQueue(data: call.arguments, result: result)
        default:
            return
        }
    }
    
    private func setQueue(data: Any?, result: @escaping FlutterResult) {
        guard let dataString = data as? String, let data = dataString.data(using: .utf8) else {
            let details = ["method": #function]
            result(FAMError.badData.toFlutterError(details))
            return
        }
        
        do {
            let queueConfig = try JSONDecoder().decode(QueueConfiguration.self, from: data)
            
            if queueConfig.overwrite {
                player.setQueue(with: queueConfig.storeIds)
            } else {
                let queueDescriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: queueConfig.storeIds)
                player.append(queueDescriptor)
            }
        } catch {
            
        }
        
    }
}

//
//  AppleMusicPlayer.swift
//  flutter_apple_music
//
//  Created by Angel Contreras on 6/6/22.
//

import FlutterMacOS
import MediaPlayer

public class AppleMusicPlayer: NSObject, FlutterPlugin {
    
    var player: MPMusicPlayerController!
    
    // MARK: StreamHandlers
    weak var playerStateChangedEvent: StreamHandler?
    weak var nowPlayingItemChangedEvent: StreamHandler?
    
    public override init() {
        super.init()
        player = MPMusicPlayerController.applicationMusicPlayer
        setupNotifications()
    }
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: PLUGIN_PATH + "/musicplayer", binaryMessenger: registrar.messenger())
        let instance = AppleMusicPlayer()
        
        registrar.addMethodCallDelegate(instance, channel: channel)
        
        registerEvents(with: registrar, instance: instance)
    }
    
    private static func registerEvents(with registrar: FlutterPluginRegistrar, instance: AppleMusicPlayer) {
        let playerStateChangedEventStreamHandler = StreamHandler()
        let nowPlayingItemChangedEventStreamHandler = StreamHandler()
        instance.playerStateChangedEvent = playerStateChangedEventStreamHandler
        instance.nowPlayingItemChangedEvent = nowPlayingItemChangedEventStreamHandler
        
        let playbackStateChangedEventChannel = FlutterEventChannel(name: AppleMusicPlayerEvents.playbackStateChangedEvent, binaryMessenger: registrar.messenger())
        playbackStateChangedEventChannel.setStreamHandler(playerStateChangedEventStreamHandler)
        
        let nowPlayingItemChangedEventChannel = FlutterEventChannel(name: AppleMusicPlayerEvents.nowPlayingItemChangedEvent, binaryMessenger: registrar.messenger())
        nowPlayingItemChangedEventChannel.setStreamHandler(nowPlayingItemChangedEventStreamHandler)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case Methods.setQueue:
            setQueue(data: call.arguments, result: result)
        case Methods.play:
            play()
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
                player.stop()
                player.setQueue(with: queueConfig.storeIds)
                player.play()
            } else {
                let queueDescriptor = MPMusicPlayerStoreQueueDescriptor(storeIDs: queueConfig.storeIds)
                player.append(queueDescriptor)
                
            }
        } catch {
            print(error)
        }
        
    }
    
    private func play() {
//        player.play()
    }
    
    deinit {
        cleanUp()
    }
}

// MARK: - Stream Handlers
extension AppleMusicPlayer {
    
    private func setupNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(playbackStateDidChange), name: .MPMusicPlayerControllerPlaybackStateDidChange, object: player)
        NotificationCenter.default.addObserver(self, selector: #selector(nowPlayingItemDidChange), name: .MPMusicPlayerControllerNowPlayingItemDidChange, object: player)
//        NotificationCenter.default.addObserver(self, selector: #selector(playbackStateDidChange), name: .MPMusicPlayerControllerQueueDidChange, object: player)
//        NotificationCenter.default.addObserver(self, selector: #selector(playbackStateDidChange), name: .MPMusicPlayerControllerVolumeDidChange, object: player)
        player.beginGeneratingPlaybackNotifications()
    }
    
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(self)
        player.endGeneratingPlaybackNotifications()
    }
    
    private func cleanUp() {
        playerStateChangedEvent = nil
        nowPlayingItemChangedEvent = nil
    }
    
    @objc private func playbackStateDidChange() {
        let state = player.playbackState.rawValue
        playerStateChangedEvent?.send(message: state)
    }
    
    @objc private func nowPlayingItemDidChange() {
        guard let nowPlayingItem = MediaItem(withPlayer: player) else { return }
        
        let encoder = JSONEncoder()
        
        do {
            let mediaItemData = try encoder.encode(nowPlayingItem)
            let mediaItemStringData = String(data: mediaItemData, encoding: .utf8)
            nowPlayingItemChangedEvent?.send(message: mediaItemStringData)
        } catch {
            print(error)
        }
    }
}


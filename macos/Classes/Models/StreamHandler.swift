//
//  StreamHandler.swift
//  flutter_apple_music
//
//  Created by Angel Contreras on 7/5/22.
//

import Foundation

protocol StreamHandlerProtocol: FlutterStreamHandler {
    var sink: FlutterEventSink? { get set }
    func send(message: Any?)
}
extension StreamHandlerProtocol {
    
    func send(message: Any?) {
        guard let sink = sink else { return }
        sink(message)
    }
}

class StreamHandler: NSObject, StreamHandlerProtocol {
    
    var sink: FlutterEventSink?
    
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        
        sink = nil
        
        return nil
    }
    
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        
        sink = events
        
        return nil
    }
    
    deinit {
        sink = nil
    }
}

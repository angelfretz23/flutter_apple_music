//
//  FAMError.swift
//  flutter_apple_music
//
//  Created by Angel Contreras on 6/7/22.
//

struct FAMError: Error {
    let code: String
    let message: String
    
    static let unsupportedMethod = FAMError(code: "10001", message: "Method Provided is not supported")
    static let badData = FAMError(code: "10002", message: "The arguments received could not be used to execute the method")
    
    var toFlutterError: (Any?) -> FlutterError {
        return { details in
            return FlutterError(code: code, message: message, details: details)
        }
    }
}

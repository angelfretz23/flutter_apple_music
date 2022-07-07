//
//  MusicPlayerState.swift
//  flutter_apple_music
//
//  Created by Angel Contreras on 7/4/22.
//

import Foundation
import MediaPlayer


struct MusicPlayerState: Codable {
    let playbackState: Int
    
    init(with player: MPMusicPlayerController) {
        playbackState = player.playbackState.rawValue
        
    }
}

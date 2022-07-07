//
//  MediaItem.swift
//  flutter_apple_music
//
//  Created by Angel Contreras on 7/5/22.
//

import Foundation
import MediaPlayer

struct MediaItem: Codable {
    let mediaType: Int
    let title: String?
    let albumTitle: String?
    let artist: String?
    let albumArtist: String?
    let genre: String?
    let composer: String?
    let playbackDuration: Double
    let albumTrackNumber: Int
    let albumTrackCount: Int
    let isExplicitItem: Bool
    let lyrics: String?
    let assetURL: String?
    let isCloudItem: Bool
    let hasProtectedAsset: Bool
    let podcastTitle: String?
    let playCount: Int
    let skipCount: Int
    let rating: Int
    let playbackStoreID: String
    
    init(withNowPlayingItem item: MPMediaItem) {
        mediaType = Int(item.mediaType.rawValue)
        title = item.title
        albumTitle = item.albumTitle
        artist = item.artist
        albumArtist = item.albumArtist
        genre = item.genre
        composer = item.composer
        playbackDuration = item.playbackDuration
        albumTrackNumber = item.albumTrackNumber
        albumTrackCount = item.albumTrackCount
        isExplicitItem = item.isExplicitItem
        lyrics = item.lyrics
        assetURL = item.assetURL?.absoluteString
        isCloudItem = item.isCloudItem
        hasProtectedAsset = item.hasProtectedAsset
        podcastTitle = item.podcastTitle
        playCount = item.playCount
        skipCount = item.skipCount
        rating = item.rating
        playbackStoreID = item.playbackStoreID
    }
    
    init?(withPlayer player: MPMusicPlayerController) {
        guard let nowPlayingItem = player.nowPlayingItem else { return nil }
        self.init(withNowPlayingItem: nowPlayingItem)
    }
}

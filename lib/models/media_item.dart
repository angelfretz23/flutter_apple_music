import 'dart:convert';

enum MediaType {
  // audio
  music,
  podcast,
  audioBook,
  audioItunesU,
  anyAudio,

  // video
  movie,
  tvshow,
  videoPodcast,
  musicVideo,
  videoItunesU,
  homeVideo,
  anyVideo,

  any
}

class MediaItem {
  MediaType mediaType;
  String? title;
  String? albumTitle;
  String? artist;
  String? albumArtist;
  String? genre;
  String? composer;
  double playbackDuration;
  int albumTrackNumber;
  int albumTrackCount;
  bool isExplicitItem;
  String? lyrics;
  String? assetURL;
  bool isCloudItem;
  bool hasProtectedAsset;
  String? podcastTitle;
  int playCount;
  int skipCount;
  int rating;
  String playbackStoreID;
  MediaItem({
    required this.mediaType,
    this.title,
    this.albumTitle,
    this.artist,
    this.albumArtist,
    this.genre,
    this.composer,
    required this.playbackDuration,
    required this.albumTrackNumber,
    required this.albumTrackCount,
    required this.isExplicitItem,
    this.lyrics,
    this.assetURL,
    required this.isCloudItem,
    required this.hasProtectedAsset,
    this.podcastTitle,
    required this.playCount,
    required this.skipCount,
    required this.rating,
    required this.playbackStoreID,
  });

  Map<String, dynamic> toMap() {
    return {
      'mediaType': mediaType.index,
      'title': title,
      'albumTitle': albumTitle,
      'artist': artist,
      'albumArtist': albumArtist,
      'genre': genre,
      'composer': composer,
      'playbackDuration': playbackDuration,
      'albumTrackNumber': albumTrackNumber,
      'albumTrackCount': albumTrackCount,
      'isExplicitItem': isExplicitItem,
      'lyrics': lyrics,
      'assetURL': assetURL,
      'isCloudItem': isCloudItem,
      'hasProtectedAsset': hasProtectedAsset,
      'podcastTitle': podcastTitle,
      'playCount': playCount,
      'skipCount': skipCount,
      'rating': rating,
      'playbackStoreID': playbackStoreID,
    };
  }

  factory MediaItem.fromMap(Map<String, dynamic> map) {
    return MediaItem(
      mediaType: MediaType.values[map['mediaType'] as int],
      title: map['title'],
      albumTitle: map['albumTitle'],
      artist: map['artist'],
      albumArtist: map['albumArtist'],
      genre: map['genre'],
      composer: map['composer'],
      playbackDuration: map['playbackDuration']?.toDouble() ?? 0.0,
      albumTrackNumber: map['albumTrackNumber']?.toInt() ?? 0,
      albumTrackCount: map['albumTrackCount']?.toInt() ?? 0,
      isExplicitItem: map['isExplicitItem'] ?? false,
      lyrics: map['lyrics'],
      assetURL: map['assetURL'],
      isCloudItem: map['isCloudItem'] ?? false,
      hasProtectedAsset: map['hasProtectedAsset'] ?? false,
      podcastTitle: map['podcastTitle'],
      playCount: map['playCount']?.toInt() ?? 0,
      skipCount: map['skipCount']?.toInt() ?? 0,
      rating: map['rating']?.toInt() ?? 0,
      playbackStoreID: map['playbackStoreID'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MediaItem.fromJson(String source) => MediaItem.fromMap(json.decode(source));

  @override
  String toString() {
    return 'MediaItem(mediaType: $mediaType, title: $title, albumTitle: $albumTitle, artist: $artist, albumArtist: $albumArtist, genre: $genre, composer: $composer, playbackDuration: $playbackDuration, albumTrackNumber: $albumTrackNumber, albumTrackCount: $albumTrackCount, isExplicitItem: $isExplicitItem, lyrics: $lyrics, assetURL: $assetURL, isCloudItem: $isCloudItem, hasProtectedAsset: $hasProtectedAsset, podcastTitle: $podcastTitle, playCount: $playCount, skipCount: $skipCount, rating: $rating, playbackStoreID: $playbackStoreID)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is MediaItem &&
      other.mediaType == mediaType &&
      other.title == title &&
      other.albumTitle == albumTitle &&
      other.artist == artist &&
      other.albumArtist == albumArtist &&
      other.genre == genre &&
      other.composer == composer &&
      other.playbackDuration == playbackDuration &&
      other.albumTrackNumber == albumTrackNumber &&
      other.albumTrackCount == albumTrackCount &&
      other.isExplicitItem == isExplicitItem &&
      other.lyrics == lyrics &&
      other.assetURL == assetURL &&
      other.isCloudItem == isCloudItem &&
      other.hasProtectedAsset == hasProtectedAsset &&
      other.podcastTitle == podcastTitle &&
      other.playCount == playCount &&
      other.skipCount == skipCount &&
      other.rating == rating &&
      other.playbackStoreID == playbackStoreID;
  }

  @override
  int get hashCode {
    return mediaType.hashCode ^
      title.hashCode ^
      albumTitle.hashCode ^
      artist.hashCode ^
      albumArtist.hashCode ^
      genre.hashCode ^
      composer.hashCode ^
      playbackDuration.hashCode ^
      albumTrackNumber.hashCode ^
      albumTrackCount.hashCode ^
      isExplicitItem.hashCode ^
      lyrics.hashCode ^
      assetURL.hashCode ^
      isCloudItem.hashCode ^
      hasProtectedAsset.hashCode ^
      podcastTitle.hashCode ^
      playCount.hashCode ^
      skipCount.hashCode ^
      rating.hashCode ^
      playbackStoreID.hashCode;
  }
}

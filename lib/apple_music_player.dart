part of flutter_apple_music;

class AppleMusicPlayer {
  final MethodChannel _methodChannel;

  static final AppleMusicPlayer _instance =
      AppleMusicPlayer(_appleMusicPlayerMethodChannel);
  static AppleMusicPlayer get instance => _instance;

  AppleMusicPlayer(this._methodChannel);

  Future<bool> prepareToPlay() async {
    final ready =
        await _methodChannel.invokeMethod(_Methods.prepareToPlay) as bool? ??
            false;
    return ready;
  }

  Future<void> play() async {
    await _methodChannel.invokeMethod(_Methods.play);
  }

  Future<bool> setQueue(QueueConfiguration data) async {
    return (await _methodChannel.invokeMethod(
        _Methods.setQueue, data.toJson()));
  }

  // Events
  late final EventChannel _playbackStateChangedEventChannel =
      const EventChannel(_AppleMusicPlayerEvents.playbackStateChangedEvent);
  late final EventChannel _nowPlayingMediaItemChangedEventChannel =
      const EventChannel(_AppleMusicPlayerEvents.nowPlayingItemChangedEvent);

  // Streams Listeners
  Stream<PlaybackState> get playbackStateChanged {
    return _playbackStateChangedEventChannel
        .receiveBroadcastStream()
        .map((event) {
      final intRepresentation = event as int;
      return PlaybackState.values[intRepresentation];
    });
  }

  Stream<MediaItem> get nowPlayingMediaItemChanged {
    return _nowPlayingMediaItemChangedEventChannel
        .receiveBroadcastStream()
        .map((data) {
      MediaItem mediaItem = MediaItem.fromJson(data);
      return mediaItem;
    });
  }
}

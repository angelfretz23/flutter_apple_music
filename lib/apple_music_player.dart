part of flutter_apple_music;

class AppleMusicPlayer {
  final MethodChannel _methodChannel;

  static final AppleMusicPlayer _instance =
      AppleMusicPlayer(_appleMusicPlayerMethodChannel);
  static AppleMusicPlayer get instance => _instance;

  AppleMusicPlayer(this._methodChannel);

  Future<void> play(QueueConfiguration data) async {
    _methodChannel.invokeMethod(Methods.play, data.toJson());
  }
}

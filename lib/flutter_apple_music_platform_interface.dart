import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_apple_music_method_channel.dart';

abstract class FlutterAppleMusicPlatform extends PlatformInterface {
  /// Constructs a FlutterAppleMusicPlatform.
  FlutterAppleMusicPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterAppleMusicPlatform _instance = MethodChannelFlutterAppleMusic();

  /// The default instance of [FlutterAppleMusicPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterAppleMusic].
  static FlutterAppleMusicPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterAppleMusicPlatform] when
  /// they register themselves.
  static set instance(FlutterAppleMusicPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}

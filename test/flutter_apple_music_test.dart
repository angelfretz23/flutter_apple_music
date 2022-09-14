import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_apple_music/flutter_apple_music.dart';
import 'package:flutter_apple_music/flutter_apple_music_platform_interface.dart';
import 'package:flutter_apple_music/flutter_apple_music_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockFlutterAppleMusicPlatform 
    with MockPlatformInterfaceMixin
    implements FlutterAppleMusicPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final FlutterAppleMusicPlatform initialPlatform = FlutterAppleMusicPlatform.instance;

  test('$MethodChannelFlutterAppleMusic is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelFlutterAppleMusic>());
  });

  test('getPlatformVersion', () async {
    FlutterAppleMusic flutterAppleMusicPlugin = FlutterAppleMusic();
    MockFlutterAppleMusicPlatform fakePlatform = MockFlutterAppleMusicPlatform();
    FlutterAppleMusicPlatform.instance = fakePlatform;
  
    expect(await flutterAppleMusicPlugin.getPlatformVersion(), '42');
  });
}

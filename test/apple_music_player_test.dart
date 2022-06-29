import 'dart:ffi';

import 'package:flutter_apple_music/flutter_apple_music.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helper/mock_method_channel.dart';

void main() {
  group('Test Apple Music Player', () {
    late MockMethodChannel methodChannel;
    late AppleMusicPlayer appleMusicPlayer;

    const songId = "123456789";

    setUp(() {
      methodChannel = MockMethodChannel();
      appleMusicPlayer = AppleMusicPlayer(methodChannel);
    });

    test('Singleton is not null', () {
      expect(AppleMusicPlayer.instance, isNotNull);
    });

    test('Play method is called', () async {
      when(() => methodChannel.invokeMethod(Methods.play, any()))
          .thenAnswer((_) => Future.value(Void));

      final queueConfig = QueueConfiguration([songId]);
      await appleMusicPlayer.play(queueConfig);
      verify(() =>
              methodChannel.invokeMethod(Methods.play, queueConfig.toJson()))
          .called(1);
    });
  });
}

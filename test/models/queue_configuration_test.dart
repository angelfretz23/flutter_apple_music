import 'package:flutter_apple_music/flutter_apple_music.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('QueueConfiguration tests', () {
    const songIdsKey = 'songIds';
    const replaceKey = 'replace';
    const songIds = ['1234', '5678'];
    const map = {songIdsKey: songIds, replaceKey: false};

    test('Instantiates with correct values', () {
      final queueConfig = QueueConfiguration(songIds, overwrite: true);
      expect(queueConfig.storeIds, songIds);
      expect(queueConfig.overwrite, isTrue);
    });
    test('copyWith returns a copy', () {
      final queueConfig = QueueConfiguration(songIds);
      final queueConfigCopy = queueConfig.copyWith();
      expect(queueConfig == queueConfigCopy, isTrue);
    });
    test('Instantiates from map', () {
      final queueConfig = QueueConfiguration.fromMap(map);

      expect(queueConfig.storeIds, songIds);
      expect(queueConfig.overwrite, isFalse);
    });
    test('toString()', () {
      final queueConfig = QueueConfiguration(songIds);
      final stringRepresentation = queueConfig.toString();

      expect(stringRepresentation.contains(songIds.toString()), isTrue);
    });

    test('Equals operator', () {
      final config1 = QueueConfiguration.fromMap(map);
      final config2 = QueueConfiguration.fromMap(map);
      expect(config1 == config2, isTrue);
    });

    test('Hashcode', () {
      final queueConfig = QueueConfiguration(songIds);
      expect(queueConfig.hashCode, isNotNull);
    });
  });
}

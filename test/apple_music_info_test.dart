import 'package:flutter/services.dart';
import 'package:flutter_apple_music/flutter_apple_music.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'helper/constants.dart';
import 'helper/mock_method_channel.dart';

void main() {
  group("Test Apple Music Info", () {
    late MockMethodChannel methodChannel;
    late AppleMusicInfo appleMusicInfo;

    setUp(() {
      methodChannel = MockMethodChannel();
      appleMusicInfo = AppleMusicInfo(methodChannel);
    });

    test('Singleton is not null', () {
      expect(AppleMusicInfo.instance, isNotNull);
    });

    test("StoreFrontCountryCode is returned", () async {
      const storefrontCountryCode = 'us';
      when(() => methodChannel.invokeMethod(Methods.storefrontCountryCode))
          .thenAnswer((_) async {
        return Future<String?>.value(storefrontCountryCode);
      });

      expect(await appleMusicInfo.storefrontCountryCode, storefrontCountryCode);
      verify(() => methodChannel.invokeMethod(Methods.storefrontCountryCode))
          .called(1);
    });

    test('Storefront Identifier is returned', () async {
      const storefrontIdentifier = 'fake_store_id';
      when(() => methodChannel.invokeMethod(Methods.storefrontIdentifier))
          .thenAnswer((_) => Future.value(storefrontIdentifier));

      expect(await appleMusicInfo.storefrontIdentifier, storefrontIdentifier);
      verify(() => methodChannel.invokeMethod(Methods.storefrontIdentifier))
          .called(1);
    });

    group("Authorization Status is returned", () {
      test('Status is not determined', () async {
        when(() => methodChannel.invokeMethod(Methods.permissions))
            .thenAnswer((_) => Future.value(0));

        expect(await appleMusicInfo.authorizationStatus,
            AuthorizationStatus.notDetermined);
        verify(() => methodChannel.invokeMethod(Methods.permissions)).called(1);
      });

      test('Status is not determined when error is thrown', () async {
        when(() => methodChannel.invokeMethod(Methods.permissions))
            .thenThrow(PlatformException(code: "Ooops"));

        expect(await appleMusicInfo.authorizationStatus,
            AuthorizationStatus.notDetermined);
        verify(() => methodChannel.invokeMethod(Methods.permissions)).called(1);
      });

      test('Status is denied', () async {
        when(() => methodChannel.invokeMethod(Methods.permissions))
            .thenAnswer((_) => Future.value(1));

        expect(await appleMusicInfo.authorizationStatus,
            AuthorizationStatus.denied);
        verify(() => methodChannel.invokeMethod(Methods.permissions)).called(1);
      });

      test('Status is restricted', () async {
        when(() => methodChannel.invokeMethod(Methods.permissions))
            .thenAnswer((_) => Future.value(2));

        expect(await appleMusicInfo.authorizationStatus,
            AuthorizationStatus.restricted);
        verify(() => methodChannel.invokeMethod(Methods.permissions)).called(1);
      });

      test('Status is authorized', () async {
        when(() => methodChannel.invokeMethod(Methods.permissions))
            .thenAnswer((_) => Future.value(3));

        expect(await appleMusicInfo.authorizationStatus,
            AuthorizationStatus.authorized);
        verify(() => methodChannel.invokeMethod(Methods.permissions)).called(1);
      });
    });

    test('Developer Token is returned', () async {
      final developerToken = appleMusicInfo.generateDeveloperToken(
          fakePEM, "teamId", "keyId", const Duration(days: 1));
      expect(developerToken, isNotNull);
    });

    test('User Token is returned', () async {
      const userToken = 'USER TOKEN';
      when(() => methodChannel.invokeMethod(Methods.userToken, any()))
          .thenAnswer((_) => Future.value(userToken));

      expect(await appleMusicInfo.userToken("developerToken"), userToken);
    });

    test('User Token is null when PlatformError is thrown', () async {
      when(() => methodChannel.invokeMethod(Methods.userToken, any()))
          .thenThrow(PlatformException(code: 'Oops'));
      expect(await appleMusicInfo.userToken('developerToken'), isNull);
    });
  });
}

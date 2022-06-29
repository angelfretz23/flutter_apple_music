part of flutter_apple_music;

class AppleMusicInfo {
  final MethodChannel _methodChannel;

  static final AppleMusicInfo _instance =
      AppleMusicInfo(_appleMusicInfoMethodChannel);
  static AppleMusicInfo get instance => _instance;

  AppleMusicInfo(
    this._methodChannel,
  );

  Future<String?> get storefrontCountryCode async {
    final storefrontCountryCode =
        await _methodChannel.invokeMethod(Methods.storefrontCountryCode);
    return storefrontCountryCode;
  }

  Future<String?> get storefrontIdentifier async {
    final storefrontId =
        await _methodChannel.invokeMethod(Methods.storefrontIdentifier);
    return storefrontId;
  }

  Future<AuthorizationStatus> get authorizationStatus async {
    try {
      int value = await _methodChannel.invokeMethod(Methods.permissions);
      AuthorizationStatus status = AuthorizationStatus.notDetermined;
      status = AuthorizationStatus.values[value];
      return Future.value(status);
    } on PlatformException catch (e) {
      return Future.value(AuthorizationStatus.notDetermined);
    }
  }

  Future<String?> generateDeveloperToken(
      String pem, String teamId, String keyId, Duration expires) async {
    Map<String, dynamic>? headers = {
      "kid": keyId,
    };

    var payload = {
      "iss": teamId,
    };

    final jwt = JWT(payload, header: headers);
    final key = ECPrivateKey(pem);
    return jwt.sign(key,
        algorithm: JWTAlgorithm.ES256, expiresIn: const Duration(days: 1));
  }

  Future<String?> userToken(String developerToken) async {
    try {
      final userToken = await _methodChannel
          .invokeMethod(Methods.userToken, <String, dynamic>{
        'developerToken': developerToken,
      });
      return userToken;
    } on PlatformException catch (e) {
      return Future.value(null);
    }
  }
}

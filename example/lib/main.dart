import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_apple_music/flutter_apple_music.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _pem =
      "-----BEGIN PRIVATE KEY-----\nMIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgVeARtBQ+epdTqoyWX/swUvs8K2tGVl7atzUlkJ9aa9CgCgYIKoZIzj0DAQehRANCAAQ9tUaiokvokpFX7qjE6F99TxgyHb970+bX5YmdZmiC3u+aMlkjLvzf74pyveOT5kFp5Hv4x+3OZENJMymzVZMd\n-----END PRIVATE KEY-----";
  final _keyId = "39K7MHK37Z";
  final _teamId = "GQMN9RP4XE";

  String _storefrontCountryCode = 'Unknown';
  String _storefrontIdentifier = 'Unknown';
  AuthorizationStatus _status = AuthorizationStatus.notDetermined;
  bool _devTokenValid = false;
  String? _userToken = "UNKOWN";

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String storefront;
    String storefrontId;
    AuthorizationStatus authorization;
    String devToken;
    String? userToken;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      final futures = await Future.wait([
        AppleMusicInfo.instance.storefrontCountryCode,
        AppleMusicInfo.instance.authorizationStatus,
        AppleMusicInfo.instance.storefrontIdentifier,
        AppleMusicInfo.instance.generateDeveloperToken(
            _pem, _teamId, _keyId, const Duration(days: 1))
      ]);

      storefront = futures[0] as String;
      authorization = futures[1] as AuthorizationStatus;
      storefrontId = futures[2] as String;
      devToken = futures[3] as String;

      userToken = await AppleMusicInfo.instance.userToken(devToken);
    } on PlatformException {
      storefront = 'Failed to get storefront.';
      authorization = AuthorizationStatus.notDetermined;
      storefrontId = 'Failed to get storefront.';
      devToken = "";
      userToken = "failed to get Token";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _storefrontCountryCode = storefront;
      _status = authorization;
      _storefrontIdentifier = storefrontId;
      _devTokenValid = devToken.isNotEmpty;
      _userToken = userToken;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Text('Apple Music Storefront: $_storefrontCountryCode\n'),
            Text('Authorization: ${_status.toString()}\n'),
            Text('Storefront Identifier: $_storefrontIdentifier\n'),
            Text(_devTokenValid
                ? "Dev Token Is Valid"
                : "Dev Token is NOT valid"),
            ElevatedButton(
              onPressed: () {
                AppleMusicPlayer.instance
                    .play(QueueConfiguration(['204672782']));
              },
              child: const Text('Play'),
            ),
          ]),
        ),
      ),
    );
  }
}

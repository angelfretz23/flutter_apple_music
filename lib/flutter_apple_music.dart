library flutter_apple_music;

import 'dart:convert';

import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'apple_music_info.dart';
part 'apple_music_player.dart';
part 'models/authorization_status.dart';
part 'models/methods.dart';
part 'models/queue_configuration.dart';

const _pluginPath = "works.theway/flutter_apple_music";

// ignore: unnecessary_late
late MethodChannel _appleMusicInfoMethodChannel =
    const MethodChannel("$_pluginPath/methods");

// ignore: unnecessary_late
late MethodChannel _appleMusicPlayerMethodChannel =
    const MethodChannel("$_pluginPath/musicplayer");

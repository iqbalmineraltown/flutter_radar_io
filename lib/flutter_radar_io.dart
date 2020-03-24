import 'dart:async';

import 'package:flutter/services.dart';

class FlutterRadarIo {
  static const MethodChannel _channel =
      const MethodChannel('flutter_radar_io');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

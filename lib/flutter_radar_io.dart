import 'dart:async';

import 'package:flutter/services.dart';

class FlutterRadarIo {
  static const MethodChannel _channel = const MethodChannel('flutter_radar_io');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> initialize(String publishableKey) async {
    var param = <String, dynamic>{
      'publishableKey': publishableKey,
    };
    _channel.invokeMethod('initialize', param);
  }

  static Future<void> setUserId(String userId) async {
    var param = <String, dynamic>{
      'userId': userId,
    };
    _channel.invokeMethod('setUserId', param);
  }

  static Future<void> setMetadata(Map metadata) async {
    var param = <String, dynamic>{
      'metadata': metadata,
    };
    _channel.invokeMethod('setMetadata', param);
  }

  static Future<void> setDescription(String description) async {
    var param = <String, dynamic>{
      'description': description,
    };
    _channel.invokeMethod('description', param);
  }

  static Future<void> startBackgroundTracking() async {
    _channel.invokeMethod('startBackgroundTracking');
  }

  static Future<void> stopBackgroundTracking() async {
    _channel.invokeMethod('stopBackgroundTracking');
  }

  static Future<bool> get isBackgroundTracking async {
    final bool isTracking = await _channel.invokeMethod('isBackgroundTracking');
    return isTracking;
  }
}

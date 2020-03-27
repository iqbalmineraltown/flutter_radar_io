import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_radar_io/flutter_radar_io.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  bool _isTracking = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();

    FlutterRadarIo.initialize(
        'prj_test_pk_2e1bf53fe29505aded6b1bb07e8ae2369f29cf0c');
    _checkTrackingState();
  }

  Future<void> _checkTrackingState() async {
    var isTracking = await FlutterRadarIo.isBackgroundTracking;

    setState(() {
      _isTracking = isTracking;
    });
  }

  void _toggleTracking() {
    if (_isTracking) {
      FlutterRadarIo.stopBackgroundTracking();
    } else {
      FlutterRadarIo.startBackgroundTracking();
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await FlutterRadarIo.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Center(
              child: Text('Running on: $_platformVersion\n'),
            ),
            RaisedButton(
              child: Text(_isTracking ? 'Stop Tracking' : 'Start Tracking'),
              onPressed: _toggleTracking,
            ),
          ],
        ),
      ),
    );
  }
}

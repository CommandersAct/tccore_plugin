import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:tccore_plugin/TCDebug.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.


    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body:Container(
          child: SingleChildScrollView(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTextButton('setDebugLevel TCLogLevel_None', () => {TCDebug().setDebugLevel(TCLogLevel.TCLogLevel_None)}),
                    buildTextButton('setDebugLevel TCLogLevel_Verbose', () => {TCDebug().setDebugLevel(TCLogLevel.TCLogLevel_Verbose)}),
                  ],
                ),
              )
          ),
        )
        ,
      ),
    );
  }


  Container buildTextButton(String label, Function() f) {
    return     Container(
        margin: const EdgeInsets.only(top: 10.0, right: 34, left: 34),
        child : ElevatedButton(
            style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue,
                minimumSize: const Size.fromHeight(50)),
            onPressed: () {f();},
            child: Text(
              label, style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,

            )));
  }
}

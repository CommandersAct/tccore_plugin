import 'package:flutter/foundation.dart';
import 'package:tccore_plugin/tccore.dart';

enum TCLogLevel
{
  TCLogLevel_Verbose,
  TCLogLevel_Debug,
  TCLogLevel_Info,
  TCLogLevel_Warn,
  TCLogLevel_Error,
  TCLogLevel_Assert,
  TCLogLevel_None,
}

class TCDebug
{
  static final TCDebug _sharedInstance = TCDebug._internal();

  factory TCDebug()
  {
    return _sharedInstance;
  }

  TCDebug._internal();

  Future<void> setDebugLevel(TCLogLevel level) async
  {
    if (defaultTargetPlatform  == TargetPlatform.android)
    {
      await TCCore.tcChannel.invokeMethod("setDebugLevel",  {"level" : (level == TCLogLevel.TCLogLevel_None ? 10 : level.index + 2)});
    }
    else if (defaultTargetPlatform == TargetPlatform.iOS)
      {
        await TCCore.tcChannel.invokeMethod("setDebugLevel", {"level" : level.toString()});
      }
  }

  Future<void> enablePrettyFormat(bool value) async
  {
    if (defaultTargetPlatform  == TargetPlatform.android)
    {
        await TCCore.tcChannel.invokeMethod("enablePrettyFormat", {"value" : value});
    }
  }

  Future<void> setNotificationLog(bool logNotification) async
  {
    await TCCore.tcChannel.invokeMethod("setNotificationLog", {"value" : logNotification});
  }

  Future<void> blockHits(bool blockHit) async
  {
    await TCCore.tcChannel.invokeMethod("blockHits", {"value" : blockHit});
  }

  Future<bool> areHitBlocked() async
  {
    return await TCCore.tcChannel.invokeMethod("areHitBlocked");
  }
}

package com.tagcommander.tccore_plugin;

import android.util.Log;

import androidx.annotation.NonNull;

import com.tagcommander.lib.core.TCAdditionalProperties;
import com.tagcommander.lib.core.TCDebug;
import com.tagcommander.lib.core.TCLogger;
import com.tagcommander.lib.core.TCUser;

import org.json.JSONObject;

import java.lang.reflect.Field;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** TccorePlugin */
public class TCCorePlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "tccore_plugin");
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    switch (call.method) {
      case "setValue":
        setValue(call.argument("key"), call.argument("value"), call.argument("class"));
        result.success(null);
        break;
      case "addAdditionalProperty":
        setAdditionalProperty(call.argument("key"), call.argument("value"), call.argument("class"), call.argument("type"));
        result.success(null);
        break;
      case "setConsentCategories":
        TCUser.getInstance().setConsentCategories(call.argument("consent_categories"));
        result.success(null);
        break;
      case "setExternalConsent":
        TCUser.getInstance().setExternalConsent(call.argument("external_consent"));
        result.success(null);
        break;
      case "setConsentVendors":
        TCUser.getInstance().setConsentVendors(call.argument("consent_vendors"));
        result.success(null);
        break;
      case "removeAdditionalProperty":
        removeAdditionalProperty(call.argument("key"), call.argument("class"));
        result.success(null);
        break;
      case "clearAdditionalProperties":
        clearAdditionalProperties(call.argument("class"));
        result.success(null);
        break;
      case "setDebugLevel":
        TCDebug.setDebugLevel(call.argument("level"));
        result.success(null);
        break;
      case "enablePrettyFormat":
        TCDebug.enablePrettyFormat(Boolean.TRUE.equals(call.argument("value")));
        result.success(null);
        break;
      case "setNotificationLog":
        TCDebug.setNotificationLog(call.argument("value"));
        result.success(null);
        break;
      case "blockHits":
        TCDebug.blockHits(Boolean.TRUE.equals(call.argument("value")));
        result.success(null);
        break;
      case "areHitBlocked":
        result.success(TCDebug.areHitBlocked());
        break;
      default:
        result.notImplemented();
        break;
    }
  }

  private void removeAdditionalProperty(String key, String className)
  {
    if (key != null)
    {
      if ("TCUser".equals(className))
      {
        TCUser.getInstance().removeAdditionalProperty(key);
      }
    }
  }

  private void clearAdditionalProperties(String className)
  {
    if ("TCUser".equals(className))
    {
      TCUser.getInstance().clearAdditionalProperties();
    }
  }

  private void setAdditionalProperty(String key, Object value, String className, String type)
  {
    TCAdditionalProperties obj = null;

    if (value != null)
    {
      switch (className)
      {
        case "TCUser":
          obj = TCUser.getInstance();
          break;
      }

      if (obj != null)
      {
        switch (type)
        {
          case "string":
            obj.addAdditionalProperty(key, (String) value);
            break;
          case "map":
            obj.addAdditionalProperty(key, new JSONObject((HashMap) value));
            break;
          case "bool":
            obj.addAdditionalProperty(key, (Boolean) value);
            break;
          case "double":
            obj.addAdditionalProperty(key, ((Double) value).floatValue());
            break;
          case "int" :
            obj.addAdditionalProperty(key, (Integer) value);
            break;
          case "list" :
            obj.addAdditionalProperty(key, (List) value);
            break;
          default:
            break;
        }
      }
    }
  }

  private void setValue(String key, Object value, String className)
  {
    if (value != null)
    {
      Class<?> clazz = null;
      Object obj = null;

      if (className.equals("TCUser"))
      {
        clazz = TCUser.getInstance().getClass();
        obj = TCUser.getInstance();
      }

      while (clazz != null)
      {
        try
        {
          Field field = clazz.getDeclaredField(key);
          field.setAccessible(true);
          field.set(obj, value);
          return;
        }
        catch (NoSuchFieldException e)
        {
          clazz = clazz.getSuperclass();
        }
        catch (Exception e)
        {
          TCLogger.getInstance().logMessage("Error while setting field for property {"+ key + "} with value {" + value +"}, :"+ e.getMessage(), Log.ERROR);
        }
      }
    }
  }


  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}

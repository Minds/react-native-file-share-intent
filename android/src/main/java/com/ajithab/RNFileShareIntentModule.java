package com.ajithab;

import com.facebook.react.bridge.ActivityEventListener;
import com.facebook.react.bridge.LifecycleEventListener;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.facebook.react.bridge.Callback;
import com.facebook.react.bridge.WritableMap;
import com.facebook.react.bridge.WritableNativeMap;
import com.facebook.react.modules.core.DeviceEventManagerModule;

import java.io.File;
import java.util.ArrayList;

import android.util.Log;
import android.widget.Toast;
import android.app.Activity;
import android.content.Intent;
import android.net.Uri;


public class RNFileShareIntentModule extends ReactContextBaseJavaModule implements ActivityEventListener, LifecycleEventListener {

  private Callback successShareCallback;
  private final ReactApplicationContext reactContext;
  private Intent mIntent = null;

  public RNFileShareIntentModule(ReactApplicationContext reactContext) {
    super(reactContext);
    this.reactContext = reactContext;
    reactContext.addActivityEventListener(this);
    reactContext.addLifecycleEventListener(this);
  }

  @Override
  public void onNewIntent(Intent aIntent) {
    /* if all processing is made on onNewIntent, that not works on the second call when application in background */

    if (mIntent == null) {
      mIntent = aIntent;
    }
  }

  @Override
  public void onHostResume() {
    Intent aIntent =  mIntent;

    if (mIntent != null) {
      mIntent = null;
      shareFile(aIntent);
    }
  }

  @Override
  public void onHostPause() {
  }

  @Override
  public void onHostDestroy() {
  }

  @ReactMethod
  public void setCallback(Callback successCallback) {
    successShareCallback = successCallback;
  }

  @ReactMethod
  public void getFilePath(Callback successCallback) {
    successShareCallback = successCallback;
    Activity mActivity = getCurrentActivity();

    if(mActivity == null) { return; }

    Intent intent = mActivity.getIntent();
    shareFile(intent);
  }

  private void shareFile(Intent intent) {
    String action = intent.getAction();
    String type = intent.getType();
    Activity currentActivity = getCurrentActivity();

    if(action == null || type == null)
      return;

    FileHelper fileHelper = new FileHelper(this.reactContext);

    WritableMap res = new WritableNativeMap();
    if (Intent.ACTION_SEND.equals(action)) {
      if (type.startsWith("text/plain")) {
        String input = intent.getStringExtra(Intent.EXTRA_TEXT);
        successShareCallback.invoke(input, type);
      } else if (type.startsWith("application/") || type.startsWith("audio/") || type.startsWith("image/") ||
              type.startsWith("video/")) {
        Uri fileUri = (Uri) intent.getParcelableExtra(Intent.EXTRA_STREAM);
        if (fileUri != null) {
          sendEvent( fileHelper.getFileData(fileUri, currentActivity, type));
        }
      }
    } else if (Intent.ACTION_SEND_MULTIPLE.equals(action)) {
      if (type.startsWith("image/") || type.startsWith("video/") || type.startsWith("audio/") || type.startsWith("application/")) {
        ArrayList<Uri> fileUris = intent.getParcelableArrayListExtra(Intent.EXTRA_STREAM);
        if (fileUris != null) {
          for (Uri uri : fileUris) {
//            res.putString( "data", fileHelper.getFileData(uri, currentActivity));
          }
//          sendEvent(res);
        }
      }
    }
  }

  @ReactMethod
  public void clearFilePath() {
    Activity mActivity = getCurrentActivity();

    if(mActivity == null) { return; }

    Intent intent = mActivity.getIntent();

    if (intent == null) { return; }

    String type = intent.getType();

    if (type == null) { return; }

    if (type.startsWith("text/") || type.startsWith("x-world/")) {
      intent.removeExtra(Intent.EXTRA_TEXT);
    } else if (type.startsWith("image/") || type.startsWith("audio/") || type.startsWith("application/") ||
            type.startsWith("message/") || type.startsWith("video/")) {
      intent.removeExtra(Intent.EXTRA_STREAM);
    }
  }
  @Override
  public String getName() {
    return "RNFileShareIntent";
  }

  @Override
  public void onActivityResult(Activity activity, int requestCode, int resultCode, Intent data) {}

  private void sendEvent(WritableMap params) {
    reactContext
            .getJSModule(DeviceEventManagerModule.RCTDeviceEventEmitter.class)
            .emit("FileShareIntent", params);
  }
}

package com.webview.flutter_filereader_example;

import android.os.Bundle;
import android.util.Log;

import com.baseflow.permissionhandler.PermissionHandlerPlugin;
import com.webview.resource.preview.FlutterResourcePreviewPlugin;

import io.flutter.app.FlutterActivity;
import io.flutter.plugins.pathprovider.PathProviderPlugin;

public class EmbedderV1Activity extends FlutterActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Log.e("ResourcePreview", "v1 初始化");
        FlutterResourcePreviewPlugin.registerWith(registrarFor("wv.io/ResourcePreview"));
        PermissionHandlerPlugin.registerWith(registrarFor("flutter.baseflow.com/permissions/methods"));
        PathProviderPlugin.registerWith(registrarFor("plugins.flutter.io/path_provider"));

    }
}

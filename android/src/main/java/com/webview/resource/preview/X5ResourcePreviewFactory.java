package com.webview.resource.preview;

import android.content.Context;

import java.util.Map;

import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.StandardMessageCodec;
import io.flutter.plugin.platform.PlatformView;
import io.flutter.plugin.platform.PlatformViewFactory;


public class X5ResourcePreviewFactory extends PlatformViewFactory {


    private final BinaryMessenger messenger;
    private FlutterResourcePreviewPlugin plugin;
    private Context mContext;


    public X5ResourcePreviewFactory(BinaryMessenger messenger, Context context,FlutterResourcePreviewPlugin plugin) {
        super(StandardMessageCodec.INSTANCE);
        this.messenger = messenger;
        this.mContext = context;
        this.plugin = plugin;

    }

    @Override
    public PlatformView create(Context context, int i, Object args) {
        Map<String, Object> params = (Map<String, Object>) args;

        return new X5ResourcePreviewView(mContext, messenger, i, params,plugin);
    }
}

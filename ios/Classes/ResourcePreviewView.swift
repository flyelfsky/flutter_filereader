//
//  ResourcePreviewView.swift
//  flutter_file_preview
//
//  Created by 胡杰 on 2019/3/6.
//

import UIKit
import WebKit

class ResourcePreviewView: NSObject,FlutterPlatformView {
    
    var _webView: ResourcePreviewWKWebView?
    
    
    
    
    
    init(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?,binaryMessenger messenger: FlutterBinaryMessenger) {
        
        super.init()
        
        let channel = FlutterMethodChannel.init(name: "wv.io/ResourcePreview_\(viewId)", binaryMessenger: messenger)
        
        channel.setMethodCallHandler { (call, result) in
            if call.method == "openFile" {
                if isSupportOpen(fileType: fileType(filePath: call.arguments as? String)){
                    
                    self.openFile(filePath: call.arguments as! String)
                    
                    result(true)
                }else{
                    result(false)
                }
                return
            }
            if call.method == "canOpen" {
                result(isSupportOpen(fileType: fileType(filePath: call.arguments as? String)))
                return
            }
            
        }
        
        self._webView = ResourcePreviewWKWebView.init(frame: frame)
        
    }
    
    
    func openFile(filePath:String)  {
        
        let url = URL.init(fileURLWithPath: filePath)
        
        if #available(iOS 9.0, *) {
            _webView?.loadFileURL(url, allowingReadAccessTo: url)
        } else {
            let request = URLRequest.init(url: url)
            _webView?.load(request)
        }
       
    }
    
    
    
    
    
    
    func view() -> UIView {
        return _webView!
    }
    
  
    
    

}

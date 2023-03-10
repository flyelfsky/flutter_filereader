#import "FlutterResourcePreviewPlugin.h"
#import <flutter_filereader/flutter_filereader-Swift.h>

@implementation FlutterResourcePreviewPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterResourcePreviewPlugin registerWithRegistrar:registrar];
}
@end

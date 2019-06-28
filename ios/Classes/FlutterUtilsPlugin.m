#import "FlutterUtilsPlugin.h"
#import <flutter_utils/flutter_utils-Swift.h>

@implementation FlutterUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUtilsPlugin registerWithRegistrar:registrar];
}
@end

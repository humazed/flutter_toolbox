#import "FlutterUtilsPlugin.h"
#import <flutter_toolbox/flutter_toolbox-Swift.h>

@implementation FlutterUtilsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterUtilsPlugin registerWithRegistrar:registrar];
}
@end

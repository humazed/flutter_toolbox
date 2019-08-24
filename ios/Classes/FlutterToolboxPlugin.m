#import "FlutterToolboxPlugin.h"
#import <flutter_toolbox/flutter_toolbox-Swift.h>

@implementation FlutterToolboxPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterToolboxPlugin registerWithRegistrar:registrar];
}
@end

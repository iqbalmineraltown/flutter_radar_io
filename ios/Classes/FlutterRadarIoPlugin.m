#import "FlutterRadarIoPlugin.h"
#if __has_include(<flutter_radar_io/flutter_radar_io-Swift.h>)
#import <flutter_radar_io/flutter_radar_io-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_radar_io-Swift.h"
#endif

@implementation FlutterRadarIoPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterRadarIoPlugin registerWithRegistrar:registrar];
}
@end

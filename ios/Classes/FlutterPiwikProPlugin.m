#import "FlutterPiwikProPlugin.h"
#if __has_include(<flutter_analytics_piwik/flutter_analytics_piwik-Swift.h>)
#import <flutter_analytics_piwik/flutter_analytics_piwik-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_analytics_piwik-Swift.h"
#endif

@implementation FlutterPiwikProPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterPiwikProPlugin registerWithRegistrar:registrar];
}
@end

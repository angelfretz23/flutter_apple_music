#import "FlutterAppleMusicPlugin.h"
#if __has_include(<flutter_apple_music/flutter_apple_music-Swift.h>)
#import <flutter_apple_music/flutter_apple_music-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_apple_music-Swift.h"
#endif

@implementation FlutterAppleMusicPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    [AppleMusicInfo registerWithRegistrar:registrar];
    [AppleMusicPlayer registerWithRegistrar: registrar];
}
@end

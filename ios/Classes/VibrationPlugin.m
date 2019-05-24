#import "VibrationPlugin.h"
#import <AudioToolbox/AudioToolbox.h>
//#import <vibration/vibration-Swift.h>

@implementation VibrationPlugin {
    Boolean _isDevice;
};

- (instancetype)init{
    self = [super init];
    _isDevice = TARGET_OS_SIMULATOR == 0;
    return self;
}

+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel* channel = [FlutterMethodChannel
                                     methodChannelWithName:@"vibration"
                                     binaryMessenger:[registrar messenger]];
    VibrationPlugin* instance = [[VibrationPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"hasVibrator" isEqualToString:call.method]) {
        result([NSNumber numberWithBool:_isDevice]);
    } else if ([@"vibrate" isEqualToString:call.method]) {
        AudioServicesPlaySystemSound (kSystemSoundID_Vibrate); 
        result(nil);
    } else if([@"cancel" isEqualToString:call.method]) {
        result(nil);
    } else {
        result(FlutterMethodNotImplemented);
    }
}
@end

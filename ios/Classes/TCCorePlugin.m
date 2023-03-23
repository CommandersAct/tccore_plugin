#import "TCCorePlugin.h"
#import "TCParser.h"

@interface TCCorePlugin ()

@property (nonatomic, retain) TCParser* parser;

@end

@implementation TCCorePlugin

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        self.parser = [[TCParser alloc] init];
    }
    
    return self;
}

+ (void) registerWithRegistrar: (NSObject<FlutterPluginRegistrar>*) registrar
{
  FlutterMethodChannel* channel = [FlutterMethodChannel methodChannelWithName: @"tccore_plugin" binaryMessenger: [registrar messenger]];
  TCCorePlugin* instance = [[TCCorePlugin alloc] init];
  [registrar addMethodCallDelegate: instance channel: channel];
}

- (void) handleMethodCall: (FlutterMethodCall*) call result: (FlutterResult) result
{
    if ([@"setValue" isEqualToString: call.method])
    {
        [self.parser setValue: call.arguments[@"value"] forProperty: call.arguments[@"key"] forCalss: call.arguments[@"class"]];
        result(nil);
    }
    else if ([@"addAdditionalProperty" isEqualToString: call.method])
    {
        [self.parser setAdditionalProperty: call.arguments[@"value"] forKey: call.arguments[@"key"] forCalss: call.arguments[@"class"] type: call.arguments[@"type"]];
        result(nil);
    }
    else if ([@"setConsentCategories" isEqualToString: call.method])
    {
        if (![call.arguments[@"consent_categories"] isEqual: [NSNull null]])
        {
            [[TCUser sharedInstance] setConsentCategories: call.arguments[@"consent_categories"]];
        }
        result(nil);
    }
    else if ([@"setExternalConsent" isEqualToString: call.method])
    {
        if (![call.arguments[@"consent_vendors"] isEqual: [NSNull null]])
        {
            [[TCUser sharedInstance] setExternalConsent: call.arguments[@"consent_vendors"]];
        }
        result(nil);
    }
    else if ([@"setConsentVendors" isEqualToString: call.method])
    {
        if (![call.arguments[@"consent_vendors"] isEqual: [NSNull null]])
        {
            [[TCUser sharedInstance] setConsentVendors: call.arguments[@"consent_vendors"]];
        }
        result(nil);
    }
    else if ([@"removeAdditionalProperty" isEqualToString: call.method])
    {
        [self removeAdditionalProperty: call.arguments[@"key"] forClass: call.arguments[@"class"]];
        result(nil);
    }
    else if ([@"clearAdditionalProperties" isEqualToString: call.method])
    {
        [self clearAdditionalProperties: call.arguments[@"class"]];
        result(nil);
    }
    else if ([@"setDebugLevel" isEqualToString: call.method])
    {
        [TCDebug setDebugLevel: [self enumValue: call.arguments[@"level"]]];
        result(nil);
    }
    else if ([@"setNotificationLog" isEqualToString: call.method])
    {
        [TCDebug setNotificationLog: call.arguments[@"value"]];
        result(nil);
    }
    else if ([@"blockHits" isEqualToString: call.method])
    {
        [TCDebug blockHits: call.arguments[@"value"]];
        result(nil);
    }
    else if ([@"areHitBlocked" isEqualToString: call.method])
    {
        result([NSNumber numberWithBool: [TCDebug areHitBlocked]]);
    }
    else
    {
        result(FlutterMethodNotImplemented);
    }
}

- (void) removeAdditionalProperty: (NSString *) key forClass: (NSString *) className
{
    if (key && ![key isEqual: [NSNull null]])
    {
        if ([className isEqualToString: @"TCUser"])
        {
            [[TCUser sharedInstance] removeAdditionalProperty: key];
        }
    }
}

- (void) clearAdditionalProperties: (NSString *) className
{
    if ([className isEqualToString: @"TCUser"])
    {
        [[TCUser sharedInstance] clearAdditionalProperties];
    }
}

- (TCLogLevel) enumValue: (NSString *) stringValue
{
    if ([stringValue isEqualToString: @"TCLogLevel.TCLogLevel_Assert"])
    {
        return TCLogLevel_Assert;
    }
    else if ([stringValue isEqualToString: @"TCLogLevel.TCLogLevel_Error"])
    {
        return TCLogLevel_Error;
    }
    else if ([stringValue isEqualToString: @"TCLogLevel.TCLogLevel_Warn"])
    {
        return TCLogLevel_Warn;
    }
    else if ([stringValue isEqualToString: @"TCLogLevel.TCLogLevel_Info"])
    {
        return TCLogLevel_Info;
    }
    else if ([stringValue isEqualToString: @"TCLogLevel.TCLogLevel_Debug"])
    {
        return TCLogLevel_Debug;
    }
    else if ([stringValue isEqualToString: @"TCLogLevel.TCLogLevel_Verbose"])
    {
        return TCLogLevel_Verbose;
    }
    else
    {
        return TCLogLevel_None;
    }
}

@end

//
//  TCParser.m
//  tc_serverside_plugin
//
//  Created by Abdelhakim SAID on 14/02/2023.
//

#import <Foundation/Foundation.h>
#import "TCParser.h"

@implementation TCParser

- (instancetype) init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

- (void) setValue: (id) value forProperty: (NSString *) property forCalss: (NSString *) className
{
    if (value && ![value isEqual: [NSNull null]])
    {
        if([className isEqualToString: @"TCUser"])
        {
            [[TCUser sharedInstance] setValue: value forKey: property];
        }
    }
}

- (void) setAdditionalProperty: (id) value forKey: (NSString *) key forCalss: (NSString *) className type: (NSString *) type;
{

    if (value && ![value isEqual: [NSNull null]])
    {
        TCAdditionalProperties *obj;
        
        if([className isEqualToString: @"TCUser"])
        {
            obj = [TCUser sharedInstance];
        }
        
        if ([type isEqualToString: @"string"])
        {
            [obj addAdditionalProperty: key withStringValue: value];
        }
        else if ([type isEqualToString: @"map"])
        {
            [obj addAdditionalProperty: key withDictValue: value];
        }
        else if ([type isEqualToString: @"bool"])
        {
            [obj addAdditionalProperty: key withBoolValue: [value boolValue]];
        }
        else if ([type isEqualToString: @"double"] || [type isEqualToString: @"int"])
        {
            [obj addAdditionalProperty: key withNumberValue: value];
        }
        else if ([type isEqualToString: @"list"])
        {
            [obj addAdditionalProperty: key withArrayValue: value];
        }
    }
}

@end

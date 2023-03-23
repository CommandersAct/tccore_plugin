//
//  TCParser.h
//  Pods
//
//  Created by Abdelhakim SAID on 14/02/2023.
//

#ifndef TCParser_h
#define TCParser_h
#import <TCCore/TCUser.h>
#import <TCCore/TCDebug.h>

@interface TCParser : NSObject

@property (nonatomic, retain) NSArray* ECOMMERCE_EVENTS;

- (void) setValue: (id) value forProperty: (NSString *) property forCalss: (NSString *) className;
- (void) setAdditionalProperty: (id) value forKey: (NSString *) key forCalss: (NSString *) className type: (NSString *) method;

@end

#endif /* TCParser_h */

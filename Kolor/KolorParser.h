//
//  KolorParser.h
//  Kolor
//
//  Created by TiBounise on 02/06/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KolorParser : NSObject {
    NSCharacterSet *nonHexaChars;
    NSDictionary *smallColorIdentifiers;
}

-(id)init;
-(BOOL)isParsable:(NSString*)colorString;
+(NSString*)getColorIdentifier:(NSMutableDictionary*)color;
+(NSString*)formatUIColor:(NSMutableDictionary*)color;
+(NSString*)formatNSColor:(NSMutableDictionary*)color;
+(NSMutableDictionary*)parseColor:(NSString*)colorString;

@end

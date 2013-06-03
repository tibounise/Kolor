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
    NSDictionary *bigColorIdentifiers;
}

-(id)init;
-(BOOL)isParsable:(NSString*)colorString;
-(NSMutableDictionary*)parseColor:(NSString*)colorString;
+(NSString*)formatNSColor:(NSMutableDictionary*)color;
+(NSString*)formatUIColor:(NSMutableDictionary*)color;
-(NSString*)getSmallColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue;
-(NSString*)getBigColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue;

@end

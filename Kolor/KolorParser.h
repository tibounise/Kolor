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
    NSMutableDictionary *color;
}

-(id)init;
-(BOOL)isParsable:(NSString*)colorString;
+(BOOL)checkLength:(NSString*)input;
-(void)parseColor:(NSString*)colorString;
-(NSString*)formatUIColor;
-(NSString*)formatNSColor;
-(NSColor*)formatDisplayColor;
+(NSString*)removeHash:(NSString*)input;
-(NSString*)getSmallColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue;
-(NSString*)getBigColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue;

@end

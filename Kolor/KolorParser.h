//
//  KolorParser.h
//  Kolor
//
//  Created by TiBounise on 02/06/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KolorParser : NSObject

+(BOOL)isParsable:(NSString*)colorString;
+(NSMutableArray*)parseColor:(NSString*)colorString;
+(NSString*)formatNSColor:(NSMutableArray*)color;
+(NSString*)formatUIColor:(NSArray*)color;
+(NSString*)getColorIdentifier:(NSMutableArray*)color;

@end

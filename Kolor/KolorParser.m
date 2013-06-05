//
//  KolorParser.m
//  Kolor
//
//  Created by TiBounise on 02/06/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "KolorParser.h"

#define DEBUG 1

@implementation KolorParser

-(id)init {
    self = [super init];
    
    if (self) {
        nonHexaChars = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFabcdef0123456789"] invertedSet];
        [nonHexaChars retain];
        
        smallColorIdentifiers = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SmallColorIdentifiers" ofType:@"plist"]];
        [smallColorIdentifiers retain];
        
        bigColorIdentifiers = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"BigColorIdentifiers" ofType:@"plist"]];
        [bigColorIdentifiers retain];
        
        color = [[NSMutableDictionary alloc] init];
        [color retain];
    }
    
    return self;
}

+(NSString*)removeHash:(NSString*)input {
    if ([input length] > 1 && [[input substringToIndex:1] isEqualToString:@"#"]) {
        return [input substringFromIndex:1];
    }
    else {
        return input;
    }
}

+(BOOL)checkLength:(NSString*)input {
    int inputLength = (int)[input length];
    return inputLength == 3 || inputLength == 6;
}

-(BOOL)isParsable:(NSString*)colorString {
    NSRange badChars = [colorString rangeOfCharacterFromSet:nonHexaChars];
    return badChars.location == NSNotFound;
}

-(void)parseColor:(NSString*)colorString {
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    int textLength = (int)[colorString length];
    unsigned int colorCode = 0,redByte,greenByte,blueByte;
    float redFloat,greenFloat,blueFloat;
    [scanner scanHexInt:&colorCode];
    
    if (textLength == 3) {
        redByte		= (colorCode & 0xF00) >> 8;
        greenByte	= (colorCode & 0xF0) >> 4;
        blueByte	= colorCode & 0xF;
        
        [color setValue:[self getSmallColorIdentifierWithRed:redByte green:greenByte blue:blueByte] forKey:@"identifier"];
        
        redFloat = (float)redByte / 0xF;
        greenFloat = (float)greenByte / 0xF;
        blueFloat = (float)blueByte / 0xF;
    }
    else {
        redByte		= (colorCode & 0xFF0000) >> 16;
        greenByte	= (colorCode & 0xFF00) >> 8;
        blueByte	= colorCode & 0xFF;
        
        [color setValue:[self getBigColorIdentifierWithRed:redByte green:greenByte blue:blueByte] forKey:@"identifier"];
        
        redFloat = (float)redByte / 0xFF;
        greenFloat = (float)greenByte / 0xFF;
        blueFloat = (float)blueByte / 0xFF;
    }
    
    [color setValue:[NSNumber numberWithFloat:redFloat] forKey:@"red"];
    [color setValue:[NSNumber numberWithFloat:greenFloat] forKey:@"green"];
    [color setValue:[NSNumber numberWithFloat:blueFloat] forKey:@"blue"];
}

-(NSString*)formatNSColor {
    if ([color objectForKey:@"identifier"]) {
        return [NSString stringWithFormat:@"[NSColor %@]",[color valueForKey:@"identifier"]];
    }
    else {
        return [NSString stringWithFormat:@"[NSColor colorWithCalibratedRed:%.03f green:%.03f blue:%.03f alpha:1.0]",
                                            [[color valueForKey:@"red"] floatValue],
                                            [[color valueForKey:@"green"] floatValue],
                                            [[color valueForKey:@"blue"] floatValue]];
    }
}

-(NSString*)formatUIColor {
    if ([color objectForKey:@"identifier"]) {
        return [NSString stringWithFormat:@"[UIColor %@]",[color valueForKey:@"identifier"]];
    }
    else {
        return [NSString stringWithFormat:@"[UIColor colorWithRed:%.03f green:%.03f blue:%.03f alpha:1.0]",
                                            [[color valueForKey:@"red"] floatValue],
                                            [[color valueForKey:@"green"] floatValue],
                                            [[color valueForKey:@"blue"] floatValue]];
    }
}

-(NSColor*)formatDisplayColor {
    return [NSColor colorWithCalibratedRed:[[color valueForKey:@"red"] floatValue]
                                     green:[[color valueForKey:@"green"] floatValue]
                                      blue:[[color valueForKey:@"blue"] floatValue]
                                     alpha:1.0f];
}

-(NSString*)getSmallColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue {
    NSEnumerator *colorEnumerator = [smallColorIdentifiers objectEnumerator];
    NSNumber *redQty = [NSNumber numberWithInt:red];
    NSNumber *greenQty = [NSNumber numberWithInt:green];
    NSNumber *blueQty = [NSNumber numberWithInt:blue];
    id colorId;
    
    while ((colorId = [colorEnumerator nextObject])) {
        if ([[colorId valueForKey:@"red"] isEqualToNumber:redQty] && [[colorId valueForKey:@"blue"] isEqualToNumber:blueQty] && [[colorId valueForKey:@"green"] isEqualToNumber:greenQty]) {
            return [colorId valueForKey:@"name"];
        }
    }
    
    return nil;
}

-(NSString*)getBigColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue {
    NSEnumerator *colorEnumerator = [bigColorIdentifiers objectEnumerator];
    NSNumber *redQty = [NSNumber numberWithInt:red];
    NSNumber *greenQty = [NSNumber numberWithInt:green];
    NSNumber *blueQty = [NSNumber numberWithInt:blue];
    id colorId;
    
    while ((colorId = [colorEnumerator nextObject])) {
        if ([[colorId valueForKey:@"red"] isEqualToNumber:redQty] && [[colorId valueForKey:@"blue"] isEqualToNumber:blueQty] && [[colorId valueForKey:@"green"] isEqualToNumber:greenQty]) {
            return [colorId valueForKey:@"name"];
        }
    }
    
    return nil;
}

@end

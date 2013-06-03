//
//  KolorParser.m
//  Kolor
//
//  Created by TiBounise on 02/06/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "KolorParser.h"

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
    }
    
    return self;
}

-(BOOL)isParsable:(NSString*)colorString {
    NSRange badChars = [colorString rangeOfCharacterFromSet:nonHexaChars];
    return badChars.location == NSNotFound;
}

-(NSMutableDictionary*)parseColor:(NSString*)colorString {
    NSMutableDictionary *output = [NSMutableDictionary dictionary];
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    int textLength = (int)[colorString length];
    unsigned int colorCode = 0,redByte,greenByte,blueByte;
    [scanner scanHexInt:&colorCode];
    
    if (textLength == 3) {
        redByte		= (colorCode & 0xF00) >> 8;
        greenByte	= (colorCode & 0xF0) >> 4;
        blueByte	= colorCode & 0xF;
        
        [output setValue:[self getSmallColorIdentifierWithRed:redByte green:greenByte blue:blueByte] forKey:@"identifier"];
        
        [output setValue:[NSNumber numberWithFloat:redByte / 0xF] forKey:@"red"];
        [output setValue:[NSNumber numberWithFloat:greenByte / 0xF] forKey:@"green"];
        [output setValue:[NSNumber numberWithFloat:blueByte / 0xF] forKey:@"blue"];
    }
    else if (textLength == 6) {
        redByte		= (colorCode & 0xFF0000) >> 16;
        greenByte	= (colorCode & 0xFF00) >> 8;
        blueByte	= colorCode & 0xFF;
        
        [output setValue:[self getBigColorIdentifierWithRed:redByte green:greenByte blue:blueByte] forKey:@"identifier"];
        
        [output setValue:[NSNumber numberWithFloat:redByte / 0xFF] forKey:@"red"];
        [output setValue:[NSNumber numberWithFloat:greenByte / 0xFF] forKey:@"green"];
        [output setValue:[NSNumber numberWithFloat:blueByte / 0xFF] forKey:@"blue"];
    }
    
    return output;
}

+(NSString*)formatNSColor:(NSMutableDictionary*)color {
    if ([color objectForKey:@"identifier"]) {
        return [NSString stringWithFormat:@"[NSColor %@]",[color valueForKey:@"identifier"]];
    }
    else {
        return [NSString stringWithFormat:@"[NSColor colorWithRed:%.03f green:%.03f blue:%.03f alpha:1.0]",
                                            [[color valueForKey:@"red"] floatValue],
                                            [[color valueForKey:@"green"] floatValue],
                                            [[color valueForKey:@"blue"] floatValue]];
    }
}

+(NSString*)formatUIColor:(NSMutableDictionary*)color {
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

-(NSString*)getSmallColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue {
    NSEnumerator *colorEnumerator = [smallColorIdentifiers objectEnumerator];
    id color;
    
    while ((color = [colorEnumerator nextObject])) {
        if ([[color valueForKey:@"red"] isEqualToNumber:[NSNumber numberWithInt:red]] && [[color valueForKey:@"blue"] isEqualToNumber:[NSNumber numberWithInt:blue]] && [[color valueForKey:@"green"] isEqualToNumber:[NSNumber numberWithInt:green]]) {
            return [color valueForKey:@"name"];
        }
    }
    
    return nil;
}

-(NSString*)getBigColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue {
    NSEnumerator *colorEnumerator = [bigColorIdentifiers objectEnumerator];
    id color;
    
    while ((color = [colorEnumerator nextObject])) {
        if ([[color valueForKey:@"red"] isEqualToNumber:[NSNumber numberWithInt:red]] && [[color valueForKey:@"blue"] isEqualToNumber:[NSNumber numberWithInt:blue]] && [[color valueForKey:@"green"] isEqualToNumber:[NSNumber numberWithInt:green]]) {
            return [color valueForKey:@"name"];
        }
    }
    
    return nil;
}

@end

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
    nonHexaChars = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFabcdef0123456789"] invertedSet];
    smallColorIdentifiers = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"SmallColorIdentifiers" ofType:@"plist"]];
    return self;
}

-(BOOL)isParsable:(NSString*)colorString {
    NSRange badChars = [colorString rangeOfCharacterFromSet:nonHexaChars];
    return badChars.location == NSNotFound;
}

+(NSMutableDictionary*)parseColor:(NSString*)colorString {
    NSMutableDictionary *output = [NSMutableDictionary dictionary];
    NSScanner *scanner = [NSScanner scannerWithString:colorString];
    int textLength = (int)[colorString length];
    unsigned int colorCode = 0,redByte,greenByte,blueByte;
    [scanner scanHexInt:&colorCode];
    
    if (textLength == 3) {
        redByte		= (colorCode & 0xF00) >> 8;
        greenByte	= (colorCode & 0xF0) >> 4;
        blueByte	= colorCode & 0xF;
        
        [output setValue:[NSNumber numberWithFloat:redByte / 0xF] forKey:@"red"];
        [output setValue:[NSNumber numberWithFloat:greenByte / 0xF] forKey:@"green"];
        [output setValue:[NSNumber numberWithFloat:blueByte / 0xF] forKey:@"blue"];
        
        
    }
    else if (textLength == 6) {
        redByte		= (unsigned char) (colorCode >> 16);
        greenByte	= (unsigned char) (colorCode >> 8);
        blueByte	= (unsigned char) (colorCode);
        
        [output setValue:[NSNumber numberWithFloat:(redByte / 0xFF)] forKey:@"red"];
        [output setValue:[NSNumber numberWithFloat:(greenByte / 0xFF)] forKey:@"green"];
        [output setValue:[NSNumber numberWithFloat:(blueByte / 0xFF)] forKey:@"blue"];
    }
    
    return output;
}

+(NSString*)formatNSColor:(NSMutableDictionary*)color {
    NSString *colorIdentifier = [self getColorIdentifier:color];
    
    if (colorIdentifier != nil) {
        return [NSString stringWithFormat:@"[NSColor %@]",colorIdentifier];
    }
    else {
        return [NSString stringWithFormat:@"[NSColor colorWithCalibratedRed:%.03f green:%.03f blue:%.03f alpha:1.0]",
                                          [colorIdentifier valueForKey:@"red"],
                                          [colorIdentifier valueForKey:@"green"],
                                          [colorIdentifier valueForKey:@"blue"]];
    }
}

+(NSString*)formatUIColor:(NSMutableDictionary*)color {
    NSString *colorIdentifier = [self getColorIdentifier:color];
    
    if (colorIdentifier != nil) {
        return [NSString stringWithFormat:@"[UIColor %@]",colorIdentifier];
    }
    else {
        return [NSString stringWithFormat:@"[UIColor colorWithRed:%.03f green:%.03f blue:%.03f alpha:1.0]",
                [colorIdentifier valueForKey:@"red"],
                [colorIdentifier valueForKey:@"green"],
                [colorIdentifier valueForKey:@"blue"]];
    }
}

-(NSString*)getSmallColorIdentifierWithRed:(int)red green:(int)green blue:(int)blue {
    NSEnumerator *smallColorEnumerator = [smallColorIdentifiers objectEnumerator];
    id color;
    
    while ((color = [smallColorEnumerator nextObject])) {
        if ([[color valueForKey:@"red"] isEqualToNumber:[NSNumber numberWithInt:red]]) {
            return [color key];
        }
    }
    
    return nil;
}

@end

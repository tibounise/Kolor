//
//  KolorParser.m
//  Kolor
//
//  Created by TiBounise on 02/06/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "KolorParser.h"

@implementation KolorParser

+(BOOL)isParsable:(NSString*)colorString {
    NSCharacterSet *NonHexaChars = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFabcdef0123456789"] invertedSet];
    NSRange badChars = [colorString rangeOfCharacterFromSet:NonHexaChars];
    return badChars.location == NSNotFound;
}

+(NSMutableArray*)parseColor:(NSString*)colorString {
    NSMutableArray *output = [NSMutableArray array];
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
        
        [output setValue:[NSNumber numberWithFloat:redByte / 0xFF] forKey:@"red"];
        [output setValue:[NSNumber numberWithFloat:greenByte / 0xFF] forKey:@"green"];
        [output setValue:[NSNumber numberWithFloat:blueByte / 0xFF] forKey:@"blue"];
    }
    
    return output;
}

+(NSString*)formatNSColor:(NSMutableArray*)color {
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

+(NSString*)formatUIColor:(NSArray*)color {
    NSString *colorIdentifier = [self getColorIdentifier:color];
    
    if (colorIdentifier != nil) {
        return [NSString stringWithFormat:@"[NSColor %@]",colorIdentifier];
    }
    else {
        return [NSString stringWithFormat:@"[UIColor colorWithRed:%.03f green:%.03f blue:%.03f alpha:1.0]",
                [colorIdentifier valueForKey:@"red"],
                [colorIdentifier valueForKey:@"green"],
                [colorIdentifier valueForKey:@"blue"]];
    }
}

+(NSString*)getColorIdentifier:(NSMutableArray*)color {
    /* Needs to be rewritten, to use a JSON file */
    
    float red,green,blue;
    
    red = [[color valueForKey:@"red"] floatValue];
    green = [[color valueForKey:@"green"] floatValue];
    blue = [[color valueForKey:@"blue"] floatValue];
    
    if (red == 0 && green == 0 && blue == 0) {
        return @"blackColor";
    }
    else if (red == 1 && green == 1 && blue == 1) {
        return @"whiteColor";
    }
    else if (red == 0 && green == 0 && blue == 1) {
        return @"blueColor";
    }
    else if (red == 1 && green == 0 && blue == 0) {
        return @"redColor";
    }
    else if (red == 0 && green == 1 && blue == 0) {
        return @"greenColor";
    }
    else if (red == 0.5 && green == 0 && blue == 0.5) {
        return @"purpleColor";
    }
    else if (red == 0.6 && green == 0.4 && blue == 0.2) {
        return @"brownColor";
    }
    else {
        return nil;
    }
}

@end

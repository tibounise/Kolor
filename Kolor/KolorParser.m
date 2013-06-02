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

@end

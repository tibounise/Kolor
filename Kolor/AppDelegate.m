//
//  AppDelegate.m
//  Kolor
//
//  Created by TiBounise on 30/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;
@synthesize hexaInput;
@synthesize nsField;
@synthesize uiField;
@synthesize hexaInputCell;

- (void)dealloc
{
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
}

- (void)controlTextDidChange:(NSNotification *)notification {
    // Gathering the text as a NSString
    NSString *hexaText = [hexaInput stringValue];
    int textLength = [hexaText length];
    
    // Length pre-check
    if (textLength > 1) {
        // If there is a "#", remove it
        if ([[hexaText substringToIndex:1] isEqualToString:@"#"]) {
            hexaText = [hexaText substringFromIndex:1];
            textLength = [hexaText length];
        }
    
        // Second length pre-check
        if (textLength == 3 || textLength == 6) {
            NSCharacterSet *NonHexaChars = [[NSCharacterSet characterSetWithCharactersInString:@"ABCDEFabcdef0123456789"] invertedSet];
            NSRange badChars = [hexaText rangeOfCharacterFromSet:NonHexaChars];
            unsigned int colorCode = 0;
            unsigned char redByte, greenByte, blueByte;
            float redDec, greenDec, blueDec;
            
            // Checking for non-hex chars
            if (badChars.location == NSNotFound) {
                [hexaInputCell setNormal];
                NSScanner *scanner = [NSScanner scannerWithString:hexaText];
                [scanner scanHexInt:&colorCode];
                
                if (textLength == 3) {
                    redByte		= (colorCode & 0xF00) >> 8;
                    greenByte	= (colorCode & 0xF0) >> 4;
                    blueByte	= colorCode & 0xF;
                    
                    redDec = (float)redByte / 0xF;
                    greenDec = (float)greenByte / 0xF;
                    blueDec = (float)blueByte / 0xF;
                }
                else if (textLength == 6) {
                    redByte		= (unsigned char) (colorCode >> 16);
                    greenByte	= (unsigned char) (colorCode >> 8);
                    blueByte	= (unsigned char) (colorCode);
                    
                    redDec = (float)redByte/0xff;
                    greenDec = (float)greenByte/0xff;
                    blueDec = (float)blueByte/0xff;
                }
                
                [nsField setStringValue:[NSString stringWithFormat:@"[NSColor colorWithCalibratedRed:%f green:%f blue:%f alpha:1.0]",redDec,greenDec,blueDec]];
                [uiField setStringValue:[NSString stringWithFormat:@"[UIColor colorWithRed:%f green:%f blue:%f alpha:1.0]",redDec,greenDec,blueDec]];
            }
            else {
                [self blackout];
            }
        }
        else {
            [self blackout];
        }
    }
    else if ([hexaText length] == 1) {
        [self blackout];
    }
    else {
        [hexaInputCell setNormal];
    }
}

-(void)blackout {
    [hexaInputCell setRed];
    [nsField setStringValue:@""];
    [uiField setStringValue:@""];
}

@end
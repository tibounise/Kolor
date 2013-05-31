//
//  AppDelegate.m
//  Kolor
//
//  Created by TiBounise on 30/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import "AppDelegate.h"

#define KolorTextInputErrorBkgColor         [NSColor colorWithCalibratedRed:0.909804 green:0.027451 blue:0.396078 alpha:1.0]

@implementation AppDelegate

@synthesize window = _window;
@synthesize hexaInput;
@synthesize nsField;
@synthesize uiField;
@synthesize hexaInputCell;
@synthesize colorWell;
@synthesize nsCopyButton;
@synthesize uiCopyButton;

NSString *nsString;
NSString *uiString;

- (void)dealloc {
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [colorWell setColor:[NSColor darkGrayColor]];
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
                
                nsString = [NSString stringWithFormat:@"[NSColor colorWithCalibratedRed:%.03f green:%.03f blue:%.03f alpha:1.0]",redDec,greenDec,blueDec];
                uiString = [NSString stringWithFormat:@"[UIColor colorWithRed:%.03f green:%.03f blue:%.03f alpha:1.0]",redDec,greenDec,blueDec];
                
                [nsField setStringValue:nsString];
                [uiField setStringValue:uiString];
                [colorWell setColor:[NSColor colorWithCalibratedRed:redDec green:greenDec blue:blueDec alpha:1.0]];
                [nsCopyButton setHidden:NO];
                [uiCopyButton setHidden:NO];
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
        [colorWell setColor:[NSColor darkGrayColor]];
        [self semiblackout];
    }
}

- (IBAction)nsCopyAction:(id)sender {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSInteger changeCount = [pasteboard clearContents];
    [pasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
    [pasteboard setString:nsString forType:NSStringPboardType];
}

- (IBAction)uiCopyAction:(id)sender {
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    NSInteger changeCount = [pasteboard clearContents];
    [pasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
    [pasteboard setString:uiString forType:NSStringPboardType];
}

-(void)blackout {
    [hexaInputCell setRed];
    [colorWell setColor:KolorTextInputErrorBkgColor];
    [self semiblackout];
}

-(void)semiblackout {
    [nsField setStringValue:@""];
    [uiField setStringValue:@""];
    [nsCopyButton setHidden:YES];
    [uiCopyButton setHidden:YES];
}

@end

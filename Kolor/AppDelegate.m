//
//  AppDelegate.m
//  Kolor
//
//  Created by TiBounise on 30/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import "AppDelegate.h"
#import "KolorParser.h"

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
NSPasteboard *pasteboard;
KolorParser *kparser;

- (void)dealloc {
    [super dealloc];
}
	
- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    [colorWell setColor:[NSColor darkGrayColor]];
    pasteboard = [NSPasteboard generalPasteboard];
    kparser = [[KolorParser alloc] init];
}

- (void)controlTextDidChange:(NSNotification *)notification {
    // Gathering the text as a NSString
    NSString *hexaText = [hexaInput stringValue];
    int textLength = (int)[hexaText length];
    
    // Length pre-check
    if (textLength > 1) {
        // If there is a "#", remove it
        if ([[hexaText substringToIndex:1] isEqualToString:@"#"]) {
            hexaText = [hexaText substringFromIndex:1];
            textLength = textLength - 1;
        }
    
        // Second length pre-check
        if (textLength == 3 || textLength == 6) {
            // Checking for non-hex chars
            if ([kparser isParsable:hexaText]) {
                [hexaInputCell setNormal];
                
                NSMutableDictionary *color = [KolorParser parseColor:hexaText];
                
                nsString = [KolorParser formatNSColor:color];
                uiString = [KolorParser formatUIColor:color];
                
                [nsField setStringValue:nsString];
                [uiField setStringValue:uiString];
                [colorWell setColor:[NSColor colorWithCalibratedRed:[[color valueForKey:@"red"] floatValue] green:[[color valueForKey:@"green"] floatValue] blue:[[color valueForKey:@"blue"] floatValue] alpha:1.0]];
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
    [self paste:nsString];
}

- (IBAction)uiCopyAction:(id)sender {
    [self paste:uiString];
}

-(void)paste:(NSString*)string {
    [pasteboard clearContents];
    [pasteboard declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
    [pasteboard setString:string forType:NSStringPboardType];
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

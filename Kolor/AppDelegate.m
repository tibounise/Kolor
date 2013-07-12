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

@synthesize window;
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
    
    // Removing eventual "#" sign
    hexaText = [KolorParser removeHash:hexaText];
    
    // Put grey background if hexaInput is empty
    if ([hexaText length] == 0) {
        [self light];
    }
    
    // Checking the length and if we can parse (if it's hex-friendly chars)
    else if ([KolorParser checkLength:hexaText] && [kparser isParsable:hexaText]) {
        // Put grey background
        [hexaInputCell setNormal];
                
        [kparser parseColor:hexaText];
        
        // Rendering the strings for NSColor & UIColor
        nsString = [kparser formatNSColor];
        uiString = [kparser formatUIColor];

        // Adding the strings in the NSTextFields
        [nsField setStringValue:nsString];
        [uiField setStringValue:uiString];
        
        // Setting the color in the box next to the hexaInput's color vier
        [colorWell setColor:[kparser formatDisplayColor]];
        
        // Enable "copy" buttons
        [nsCopyButton setHidden:NO];
        [uiCopyButton setHidden:NO];
    }
    else {
        [self blackout];
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

-(void)light {
    [hexaInputCell setNormal];
    [colorWell setColor:[NSColor darkGrayColor]];
    [self semiblackout];
}

@end

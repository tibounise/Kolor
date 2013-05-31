//
//  AppDelegate.h
//  Kolor
//
//  Created by TiBounise on 30/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "KolorTextInput.h"

@interface AppDelegate : NSObject <NSApplicationDelegate>

@property (assign) IBOutlet NSWindow *window;
@property (assign) IBOutlet NSTextField *hexaInput;
@property (assign) IBOutlet NSTextField *nsField;
@property (assign) IBOutlet NSTextField *uiField;
@property (assign) IBOutlet KolorTextInput *hexaInputCell;
@property (assign) IBOutlet NSColorWell *colorWell;

-(void)blackout;

@end

//
//  KolorView.m
//  Kolor
//
//  Created by TiBounise on 30/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import "KolorView.h"

@implementation KolorView

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [[NSColor colorWithDeviceRed:0.352941 green:0.368627 blue:0.368627 alpha:1.0] set];
    NSRectFill([self bounds]);
}

@end

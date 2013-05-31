//
//  KolorPreview.m
//  Kolor
//
//  Created by TiBounise on 31/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import "KolorPreview.h"

@implementation KolorPreview

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        bkgColor = [NSColor darkGrayColor];
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    [bkgColor set];
    NSRectFill([self bounds]);
}

-(void)setBkg:(NSColor*)color {
    NSLog(@"PING");
    bkgColor = color;
}

@end

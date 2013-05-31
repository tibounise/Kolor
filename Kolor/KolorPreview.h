//
//  KolorPreview.h
//  Kolor
//
//  Created by TiBounise on 31/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface KolorPreview : NSView {
    NSColor *bkgColor;
}

-(void)setBkg:(NSColor*)color;
-(void)drawRect:(NSRect)dirtyRect;
-(id)initWithFrame:(NSRect)frame;

@end

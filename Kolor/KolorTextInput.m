//
//  KolorTextInput.m
//  Kolor
//
//  Created by TiBounise on 30/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import "KolorTextInput.h"

#define KolorTextInputColor                 [NSColor whiteColor]
#define KolorTextInputBkgColor              [NSColor darkGrayColor]
#define KolorTextInputSelectColor           [NSColor cyanColor]

@implementation KolorTextInput

-(id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        [self setTextColor:KolorTextInputColor];
        [self setDrawsBackground:NO];
        [self setFocusRingType:NSFocusRingTypeNone];
    }
    return self;
}

-(NSText*)setUpFieldEditorAttributes:(NSText *)textObj {
    NSTextView *fieldEditor = (NSTextView*)[super setUpFieldEditorAttributes:textObj];
    NSColor *textColor = KolorTextInputColor;
    
    [fieldEditor setInsertionPointColor:textColor];
    [fieldEditor setTextColor:textColor];
    [fieldEditor setDrawsBackground:NO];
    
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[fieldEditor selectedTextAttributes]];
    [attributes setObject:KolorTextInputSelectColor forKey:NSBackgroundColorAttributeName];
    [fieldEditor setSelectedTextAttributes:attributes];
    
    return fieldEditor;
}

- (void)drawWithFrame:(NSRect)cellFrame inView:(NSView *)controlView {
    NSRect backgroundRect = cellFrame;
    backgroundRect.size.height -= 0.0f;
    
    NSBezierPath *backgroundPath = [NSBezierPath bezierPathWithRect:backgroundRect];
    
    if (bkgColor != nil) {
        [bkgColor set];
    } else {
        [KolorTextInputBkgColor set];
    }
    [backgroundPath fill];
    
    NSSize textSize = [self cellSizeForBounds:cellFrame];
    NSRect textRect = NSMakeRect(backgroundRect.origin.x, backgroundRect.origin.y, backgroundRect.size.width, textSize.height);
    [self drawInteriorWithFrame:textRect inView:controlView];
}

-(void)setBkgColor:(NSColor*)color {
    bkgColor = color;
}

-(void)setRed {
    bkgColor = [NSColor redColor];
}

-(void)setNormal {
    bkgColor = nil;
}

@end

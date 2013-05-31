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
#define KolorTextInputSelectColor           [NSColor colorWithCalibratedRed:0.631373 green:0.854902 blue:0.831373 alpha:1.0]
#define KolorTextInputErrorBkgColor         [NSColor colorWithCalibratedRed:0.909804 green:0.027451 blue:0.396078 alpha:1.0]

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
    
    if (bkgColor == 1) {
        [KolorTextInputErrorBkgColor set];
    } else {
        [KolorTextInputBkgColor set];
    }
    [backgroundPath fill];
    
    NSSize textSize = [self cellSizeForBounds:cellFrame];
    NSRect textRect = NSMakeRect(backgroundRect.origin.x, backgroundRect.origin.y, backgroundRect.size.width, textSize.height);
    [self drawInteriorWithFrame:textRect inView:controlView];
}

-(void)setRed {
    bkgColor = 1;
}

-(void)setNormal {
    bkgColor = 0;
}

@end

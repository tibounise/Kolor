//
//  KolorTextInput.h
//  Kolor
//
//  Created by TiBounise on 30/05/13.
//  Copyright (c) 2013 TiBounise. All rights reserved.
//

#import <AppKit/AppKit.h>

@interface KolorTextInput : NSTextFieldCell {
    int bkgColor;
}

-(id)initWithCoder:(NSCoder *)aDecoder;
-(NSText*)setUpFieldEditorAttributes:(NSText *)textObj;
-(void)setRed;
-(void)setNormal;

@end

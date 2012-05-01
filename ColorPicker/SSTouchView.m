//
//  SSTouchView.m
//  ColorPicker
//
//  Created by David Douglas on 4/29/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import "SSTouchView.h"

@implementation SSTouchView
@synthesize delegate;

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    [delegate touchesBegan:touches withEvent:event from:self];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesMoved:touches withEvent:event];
    [delegate touchesBegan:touches withEvent:event from:self];
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesEnded:touches withEvent:event];
    [delegate touchesEnded:touches withEvent:event from:self];
}

@end

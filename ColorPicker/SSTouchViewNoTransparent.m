//
//  SSTouchViewNoTransparent.m
//  PopTops
//
//  Created by David Douglas on 5/9/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import "SSTouchViewNoTransparent.h"

@implementation SSTouchViewNoTransparent
@synthesize shouldForwardTouches;

BOOL ImagePointIsTransparent(UIImage *uIImage, CGPoint p)
{
    CGImageRef image = [uIImage CGImage];
    
    unsigned char pixel[1] = {0};
    
    CGContextRef context = CGBitmapContextCreate(pixel, 1, 1, 8, 1, nil, kCGImageAlphaOnly);
    
    CGContextDrawImage(context, CGRectMake(-p.x,
                                           -(uIImage.size.height - p.y),
                                           CGImageGetWidth(image),
                                           CGImageGetHeight(image)),
                       image);
    CGContextRelease(context);
    
    CGFloat alpha = pixel[0]/255.0;
    
    return (alpha < 0.01);
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event
{
    BOOL isTransparent = ImagePointIsTransparent([self image], point);
    [self setShouldForwardTouches:isTransparent];
    return [super pointInside:point withEvent:event];
}
@end

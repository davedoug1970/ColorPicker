//
//  ColourUtils.m
//  SketchShareMenu
//
//  Created by stewart hamilton-arrandale on 02/12/2011.
//  Copyright (c) 2011 creative wax limited. All rights reserved.
//

#import "ColourUtils.h"

@implementation ColourUtils

@synthesize rgb, hsv;

#pragma mark - Initialization

static ColourUtils *sharedHelper = nil;
+ (ColourUtils *) sharedInstance
{
    if (!sharedHelper)
    {
        sharedHelper = [[ColourUtils alloc] init];
        
        RGBA rgb;
        rgb.r	= 0;
        rgb.g	= 0;
        rgb.b	= 0;
        rgb.a	= 1;
        
        HSV hsv;
        hsv.h	= 0;
        hsv.s	= 0;
        hsv.v	= 0;
        
        sharedHelper.rgb	= rgb;
        sharedHelper.hsv	= hsv;
    }
    return sharedHelper;
}
- (void)updateRGB:(RGBA)newRGB
{
    // update references
    self.rgb	= newRGB;
    self.hsv	= [self HSVfromRGB:newRGB];
}

- (void)updateHSV:(HSV)newHSV
{
    // update references
    self.hsv	= newHSV;
    self.rgb	= [self RGBfromHSV:newHSV];
}

- (HSV)HSVfromRGB:(RGBA)value
{
    HSV         out;
    double      min, max, delta;
    
    min = value.r < value.g ? value.r : value.g;
    min = min  < value.b ? min  : value.b;
    
    max = value.r > value.g ? value.r : value.g;
    max = max  > value.b ? max  : value.b;
    
    out.v = max;                                // v
    delta = max - min;
    if( max > 0.0 ) {
        out.s = (delta / max);                  // s
    } else {
        // r = g = b = 0                        // s = 0, v is undefined
        out.s = 0.0;
        out.h = NAN;                            // its now undefined
        return out;
    }
    if( value.r >= max )                           // > is bogus, just keeps compilor happy
        out.h = ( value.g - value.b ) / delta;        // between yellow & magenta
    else
        if( value.g >= max )
            out.h = 2.0 + ( value.b - value.r ) / delta;  // between cyan & yellow
        else
            out.h = 4.0 + ( value.r - value.g ) / delta;  // between magenta & cyan
    
    out.h *= 60.0;                              // degrees
    
    if( out.h < 0.0 )
        out.h += 360.0;
    
    return out;
}


- (RGBA)RGBfromHSV:(HSV)value
{
    double      hh, p, q, t, ff;
    long        i;
    RGBA        out;
    out.a		= rgb.a;
    
    if(value.s <= 0.0) {       // < is bogus, just shuts up warnings
        if(isnan(value.h)) {   // value.h == NAN
            out.r = value.v;
            out.g = value.v;
            out.b = value.v;
            return out;
        }
        // error - should never happen
        out.r = 0.0;
        out.g = 0.0;
        out.b = 0.0;
        return out;
    }
    hh = value.h;
    if(hh >= 360.0) hh = 0.0;
    hh /= 60.0;
    i = (long)hh;
    ff = hh - i;
    p = value.v * (1.0 - value.s);
    q = value.v * (1.0 - (value.s * ff));
    t = value.v * (1.0 - (value.s * (1.0 - ff)));
    
    switch(i) {
        case 0:
            out.r = value.v;
            out.g = t;
            out.b = p;
            break;
        case 1:
            out.r = q;
            out.g = value.v;
            out.b = p;
            break;
        case 2:
            out.r = p;
            out.g = value.v;
            out.b = t;
            break;
            
        case 3:
            out.r = p;
            out.g = q;
            out.b = value.v;
            break;
        case 4:
            out.r = t;
            out.g = p;
            out.b = value.v;
            break;
        case 5:
        default:
            out.r = value.v;
            out.g = p;
            out.b = q;
            break;
    }
    return out;     
}

+(UIImage *) newImageFromMaskImage:(UIImage *)mask inColor:(UIColor *) color {
    CGImageRef maskImage = mask.CGImage;
    CGFloat width = mask.size.width;
    CGFloat height = mask.size.height;
    CGRect bounds = CGRectMake(0,0,width,height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
    CGContextClipToMask(bitmapContext, bounds, maskImage);
    CGContextSetFillColorWithColor(bitmapContext, color.CGColor);    
    CGContextFillRect(bitmapContext, bounds);
    
    CGImageRef mainViewContentBitmapContext = CGBitmapContextCreateImage(bitmapContext);
    CGContextRelease(bitmapContext);
    
    UIImage *result = [UIImage imageWithCGImage:mainViewContentBitmapContext];
    return result;
}
@end

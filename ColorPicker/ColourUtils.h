//
//  ColourUtils.h
//  SketchShareMenu
//
//  Created by stewart hamilton-arrandale on 02/12/2011.
//  Copyright (c) 2011 creative wax limited. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef struct {
    double r;       // percent
    double g;       // percent
    double b;       // percent
    double a;       // percent
} RGBA;

typedef struct {
    double h;       // angle in degrees
    double s;       // percent
    double v;       // percent
} HSV;


@interface ColourUtils : NSObject
{
    RGBA	rgb;
    HSV		hsv;
}

@property (readwrite) RGBA rgb;
@property (readwrite) HSV hsv;

+ (ColourUtils *) sharedInstance;
- (void)updateRGB:(RGBA)newRGB;
- (void)updateHSV:(HSV)newHSV;
- (HSV)HSVfromRGB:(RGBA)value;
- (RGBA)RGBfromHSV:(HSV)value;
+ (UIImage *) newImageFromMaskImage:(UIImage *)mask inColor:(UIColor *) color;


@end

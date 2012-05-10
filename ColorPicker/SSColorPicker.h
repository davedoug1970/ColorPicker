//
//  SSColorPicker.h
//  ColorPicker
//
//  Created by David Douglas on 4/28/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SSTouchView.h"
#import "ColourUtils.h"

/** @def CC_RADIANS_TO_DEGREES
 converts radians to degrees
 */
#define CC_RADIANS_TO_DEGREES(__ANGLE__) ((__ANGLE__) * 57.29577951f) // PI * 180

/** @def CC_DEGREES_TO_RADIANS
 converts degrees to radians
 */
#define CC_DEGREES_TO_RADIANS(__ANGLE__) ((__ANGLE__) * 0.01745329252f) // PI / 180

@protocol SSColorPickerDelegate <NSObject>

- (void)colorChanged:(UIColor *)color from:(id)sender;

@end

@interface SSColorPicker : UIViewController<SSTouchViewDelegate>

@property (weak,nonatomic) IBOutlet UIImageView *bkgd;
@property (weak,nonatomic) IBOutlet UIImageView *huebkgd;
@property (weak,nonatomic) IBOutlet UIImageView	*overlay;
@property (weak,nonatomic) IBOutlet UIImageView	*shadow;
@property (assign,nonatomic) CGFloat saturation;
@property (assign,nonatomic) CGFloat brightness;
@property (assign,nonatomic) CGFloat percentage;
@property (assign,nonatomic) int boxPos;
@property (assign,nonatomic) int boxSize;
@property (strong,nonatomic) ColourUtils *colorUtils;

@property (weak,nonatomic) IBOutlet SSTouchView *hueSelector;
@property (weak,nonatomic) IBOutlet SSTouchView *colorSelector;
@property (weak,nonatomic) id<SSColorPickerDelegate> delegate;

-(void) setColor:(UIColor *)color;






@end

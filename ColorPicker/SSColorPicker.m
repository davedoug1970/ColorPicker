//
//  SSColorPicker.m
//  ColorPicker
//
//  Created by David Douglas on 4/28/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import "SSColorPicker.h"
#import "ColourUtils.h"

@interface SSColorPicker ()

@end

@implementation SSColorPicker
@synthesize hueSelector, colorSelector, bkgd, huebkgd, boxPos, boxSize, overlay, shadow, saturation,brightness, percentage, colorUtils, delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	if (self)
	{
        [self setBoxPos:35];	// starting position of the virtual box area for picking a colour
        [self setBoxSize:165];	// the size (width and height) of the virtual box for picking a colour from
        [self setColorUtils:[ColourUtils sharedInstance]];
        [self setBrightness:.8];
        [self setSaturation:.8];
        [self setPercentage:0.0];
	}
	return self;
}

- (void)setColor:(UIColor *)color
{
    CGFloat h;
    CGFloat s;
    CGFloat b;
    CGFloat a;
    
    [color getHue:&h saturation:&s brightness:&b alpha:&a];
    
    [self setPercentage:h];
    [self setSaturation:s];
    [self setBrightness:b];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //[self updateColorPosition:[[self colorSelector] center]];
    [self updateWithPercentage:[self percentage]];
    [self updateToColor];
    [self colorChanged];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)updateToColor
{
    [[self bkgd] setImage:[ColourUtils newImageFromMaskImage:[[self bkgd] image] inColor:[UIColor colorWithHue:[self percentage] saturation:1.0f brightness:1.0f alpha:1.0f]]];
}

-(void)updateColorPosition:(CGPoint)sliderPosition
{
    // clamp the position of the icon within the circle
    
    // get the center point of the bkgd image
    float centerX		= self.bkgd.bounds.size.width*.5;  
    float centerY		= self.bkgd.bounds.size.height*.5;   
    // work out the distance difference between the location and center
    float dx			= sliderPosition.x - centerX;
    float dy			= sliderPosition.y - centerY;
    float dist			= sqrtf(dx*dx+dy*dy);
    
    // update angle by using the direction of the location
    float angle			= atan2f(dy, dx);
    
    // set the limit to the slider movement within the colour picker
    float limit			= self.bkgd.bounds.size.width*.5;
    
    // check distance doesn't exceed the bounds of the circle
    if (dist > limit)
    {
        sliderPosition.x	= centerX + limit * cosf(angle);
        sliderPosition.y	= centerY + limit * sinf(angle);
    }
    
    // set the position of the dragger
    [[self colorSelector] setCenter:[[self bkgd] convertPoint:sliderPosition toView:[self view]]]; 
    
    // use the position / slider width to determin the percentage the dragger is at
    [self setSaturation:1 - ABS(sliderPosition.x/self.boxSize)];
    [self setBrightness:1 - ABS(sliderPosition.y/self.boxSize)];
}

-(void)checkColorPosition:(CGPoint)location
{
    // clamp the position of the icon within the circle
    
    // get the center point of the bkgd image
    float centerX		= self.bkgd.bounds.size.width*.5; 
    float centerY		= self.bkgd.bounds.size.height*.5; 
    
    // work out the distance difference between the location and center
    float dx			= location.x - centerX;
    float dy			= location.y - centerY;
    float dist			= sqrtf(dx*dx+dy*dy);
    
    // check that the touch location is within the bounding rectangle before sending updates
	if (dist <= self.bkgd.bounds.size.width*.5)
    {
        [self updateColorPosition:location];
        [self colorChanged];
    }
}

-(void) updateWithPercentage:(CGFloat)newPercentage
{
    // clamp the position of the icon within the circle
    
    // get the center point of the bkgd image
    float centerX		= self.huebkgd.bounds.size.width*.5;
    float centerY		= self.huebkgd.bounds.size.height*.5;
    
    // work out the limit to the distance of the picker when moving around the hue bar
    float limit			= self.huebkgd.bounds.size.width*.5 - 11;
    
    // update angle
    float angleDeg		= newPercentage * 360.0f - 180.0f;
    float angle			= CC_DEGREES_TO_RADIANS(angleDeg);
    
    // set new position of the slider
    float x				= centerX + limit * cosf(angle);
    float y				= centerY + limit * sinf(angle);
    [[self hueSelector] setCenter:[[self huebkgd] convertPoint:CGPointMake(x, y) toView:[self view]]]; 
    
    // update percentage reference
    percentage			= newPercentage;
}

-(void)updateHuePosition:(CGPoint)sliderPosition
{
    // clamp the position of the icon within the circle
    
    // get the center point of the bkgd image
    float centerX		= self.huebkgd.bounds.size.width*.5;
    float centerY		= self.huebkgd.bounds.size.height*.5;
    
    // work out the distance difference between the location and center
    float dx			= sliderPosition.x - centerX;
    float dy			= sliderPosition.y - centerY;
    
    // update angle by using the direction of the location
    float angle			= atan2f(dy, dx);
    float angleDeg		= CC_RADIANS_TO_DEGREES(angle)+180;
    
    // use the position / slider width to determin the percentage the dragger is at
    self.percentage		= angleDeg/360.0f;
    
    [self updateWithPercentage:[self percentage]];
}

-(void)checkHuePosition:(CGPoint)location
{
    if (CGRectContainsPoint(self.huebkgd.bounds, location))
    {
        [self updateHuePosition:location];
        [self updateToColor];
        [self colorChanged];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event from:(id)sender
{
    UITouch *touch = [touches anyObject];
    CGPoint location;
    
    if ([(SSTouchView *)sender tag] == 2) {
        location = [touch locationInView:[self bkgd]];
        [self checkColorPosition:location];
    } else if ([(SSTouchView *)sender tag] == 7) {
        location = [touch locationInView:[self huebkgd]];	// get the touch position
        [self checkHuePosition:location];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event from:(id)sender
{
    UITouch *touch = [touches anyObject];   
    CGPoint location;	
    
    if ([(SSTouchView *)sender tag] == 5) {
        location = [touch locationInView:[touch view]];	// get the touch position
        [self checkColorPosition:location];
    } else if ([(SSTouchView *)sender tag] == 10) {
        location = [touch locationInView:[self huebkgd]];	// get the touch position
        [self checkHuePosition:location];
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event from:(id)sender
{
    //
}

- (void)colorChanged
{
    [[self delegate] colorChanged:[UIColor colorWithHue:[self percentage] saturation:[self saturation] brightness:[self brightness] alpha:1.0f] from:self];
}
@end

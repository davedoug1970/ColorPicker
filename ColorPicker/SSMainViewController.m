//
//  SSMainViewController.m
//  ColorPicker
//
//  Created by David Douglas on 4/26/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import "SSMainViewController.h"

@interface SSMainViewController ()

@end

@implementation SSMainViewController
@synthesize colorPicker;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Flipside View

- (void)flipsideViewControllerDidFinish:(SSFlipsideViewController *)controller
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)showInfo:(id)sender
{    
    SSFlipsideViewController *controller = [[SSFlipsideViewController alloc] initWithNibName:@"SSFlipsideViewController" bundle:nil];
    controller.delegate = self;
    controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentModalViewController:controller animated:YES];
}

- (void)colorChanged:(UIColor *)color from:(id)sender
{
    [[self view] setBackgroundColor:color];
}

- (void)dismiss:(id)sender
{
    [UIView animateWithDuration:.6 animations:^{
        [[[self colorPicker] view] setAlpha:0];
        [self setColorPicker:nil];
    }];
}

- (IBAction)show:(id)sender
{
    [self setColorPicker:[[SSColorPicker alloc] initWithNibName:@"SSColorPicker" bundle:nil]];
    [[self colorPicker] setDelegate:self];
    //[[self colorPicker] setColor:[[self view] backgroundColor]];
    
    [[self colorPicker] showColorPicker:[[self view] backgroundColor]];
}
@end

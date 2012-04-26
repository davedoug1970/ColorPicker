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

@end

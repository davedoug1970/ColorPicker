//
//  SSFlipsideViewController.m
//  ColorPicker
//
//  Created by David Douglas on 4/26/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import "SSFlipsideViewController.h"

@interface SSFlipsideViewController ()

@end

@implementation SSFlipsideViewController

@synthesize delegate = _delegate;

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

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

@end

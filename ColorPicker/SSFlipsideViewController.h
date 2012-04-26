//
//  SSFlipsideViewController.h
//  ColorPicker
//
//  Created by David Douglas on 4/26/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSFlipsideViewController;

@protocol SSFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(SSFlipsideViewController *)controller;
@end

@interface SSFlipsideViewController : UIViewController

@property (weak, nonatomic) id <SSFlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end

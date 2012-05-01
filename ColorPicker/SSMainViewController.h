//
//  SSMainViewController.h
//  ColorPicker
//
//  Created by David Douglas on 4/26/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import "SSFlipsideViewController.h"
#import "SSColorPicker.h"

@interface SSMainViewController : UIViewController <SSFlipsideViewControllerDelegate, SSColorPickerDelegate>

@property (strong,nonatomic) SSColorPicker *colorPicker;

- (IBAction)showInfo:(id)sender;

@end

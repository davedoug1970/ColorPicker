//
//  SSTouchView.h
//  ColorPicker
//
//  Created by David Douglas on 4/29/12.
//  Copyright (c) 2012 Software Smoothie. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SSTouchViewDelegate <NSObject>

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event from:(id)sender;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event from:(id)sender;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event from:(id)sender;

@end

@interface SSTouchView : UIImageView

@property (weak,nonatomic) IBOutlet id<SSTouchViewDelegate> delegate;

@end

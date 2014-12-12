//
//  TextFieldFloatingLabel.m
//  floating-label
//
//  Created by Diego Maehler on 11/12/14.
//  Copyright (c) 2014 Diego Maehler. All rights reserved.
//

#import "TextFieldFloatingLabel.h"

@implementation TextFieldFloatingLabel

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initFloatingLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self initFloatingLabel];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initFloatingLabel];
    }
    return self;
}

- (void) initFloatingLabel
{
    self.floatingLabel = [[UILabel alloc] init];
    self.floatingLabel.adjustsFontSizeToFitWidth = NO;
    
    [self addTarget:self
             action:@selector(textFieldChanged:)
   forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChanged:(id)sender
{
    
    if (self.text && [self.text length] > 0 && !self.floatingLabel.superview && self.placeholder && [self.placeholder length] > 0) {
    
        CGRect bounds = [self editingRectForBounds:self.textInputView.frame];
        
        [self.floatingLabel removeFromSuperview];
        
        self.floatingLabel.text = self.placeholder;
        self.placeholder = @"";
        self.floatingLabel.font = self.font;
        self.floatingLabel.alpha = 0.3;
        
        //Calculate the position for the label adding the top margins, in case of textField
        //has its text positioned bottom, making the label start his animation seeming the
        //placeholder was moving out.
        self.floatingLabel.frame = CGRectMake(bounds.origin.x,
                                              bounds.origin.y + self.textInputView.layoutMargins.top + self.layoutMargins.top,
                                              self.textInputView.frame.size.width,
                                              self.textInputView.frame.size.height);
        
        [self addSubview:self.floatingLabel];
        
        //Scale the label like it has 8points font size
        CGFloat delta = 8 / self.floatingLabel.font.pointSize;
        
        //Duration of animation based on how much the label will move in screen.
        //Further = longer duration, nearer = shorter duration
        //Calculate 25% of the delta as duration, for faster animation
        CGFloat duration = delta * 0.25;

        [UIView animateWithDuration:duration
                         animations:^{
                             self.floatingLabel.transform = CGAffineTransformScale(self.floatingLabel.transform,
                                                                                   delta,
                                                                                   delta);
                             self.floatingLabel.frame = CGRectMake(bounds.origin.x,
                                                                   0,
                                                                   self.floatingLabel.frame.size.width,
                                                                   self.floatingLabel.frame.size.height);
                             self.floatingLabel.alpha = 1;
                         }];
        
    } else if ((!self.text || [self.text length] == 0) && self.floatingLabel.superview) {

        CGRect bounds = [self editingRectForBounds:self.textInputView.frame];
        
        //Scale the label to the size of the placeholder
        CGFloat delta = self.floatingLabel.font.pointSize / 8;
        
        //Calculate 20% of the delta as duration for even shorter animation when
        //the label "is coming back"
        CGFloat duration = (8 / self.font.pointSize) * 0.2;

        [UIView animateWithDuration:duration
                         animations:^{
                             self.floatingLabel.transform = CGAffineTransformScale(self.floatingLabel.transform,
                                                                                   delta,
                                                                                   delta);
                             
                             //Position the label as if is the placeholder
                             self.floatingLabel.frame = CGRectMake(bounds.origin.x,
                                                                   bounds.origin.y + self.textInputView.layoutMargins.top + self.layoutMargins.top,
                                                                   self.textInputView.frame.size.width,
                                                                   self.textInputView.frame.size.height);
                             self.floatingLabel.alpha = 0.3;
                         }
                         completion:^(BOOL finished) {
                             [self.floatingLabel removeFromSuperview];
                             self.placeholder = self.floatingLabel.text;
                         }];
        
    }
}

@end

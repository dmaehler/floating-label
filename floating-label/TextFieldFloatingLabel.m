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
        [self addListener];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addListener];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addListener];
    }
    return self;
}

- (void) addListener
{
    [self addTarget:self action:@selector(textFieldChanged:) forControlEvents:UIControlEventEditingChanged];
}

- (void)textFieldChanged:(id)sender
{
    if (self.text && [self.text length] > 0 && !self.floatingLabel) {
        self.floatingLabel = [[UILabel alloc] init];
        self.floatingLabel.font = [UIFont boldSystemFontOfSize:15];
        self.floatingLabel.text = self.placeholder;
        [self.floatingLabel sizeToFit];
        [self addSubview:self.floatingLabel];
    } else if ((!self.text || [self.text length] == 0) && self.floatingLabel) {
        [self.floatingLabel removeFromSuperview];
        self.floatingLabel = nil;
    }
}

@end

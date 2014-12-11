//
//  TextFieldFloatingLabel.h
//  floating-label
//
//  Created by Diego Maehler on 11/12/14.
//  Copyright (c) 2014 Diego Maehler. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextFieldFloatingLabel : UITextField

@property (nonatomic, strong) UILabel *floatingLabel;

- (void) addListener;

@end

//
//  WCLabel.m
//  TestPickerView
//
//  Created by fone on 12/18/56 BE.
//  Copyright (c) 2556 BuildTheDot. All rights reserved.
//

#import "WCLabel.h"

@implementation WCLabel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (BOOL)isUserInteractionEnabled
{
    return YES;
}

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

# pragma mark - UIResponder overrides

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self becomeFirstResponder];
}

@end

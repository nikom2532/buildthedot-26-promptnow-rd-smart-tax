//
//  KeyboardViewController.h
//
//  Created by MECHIN on 10/25/2556 BE.
//  Copyright (c) 2556 buildthedot. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyboardViewController : UIViewController <UITextFieldDelegate ,UIScrollViewDelegate ,UIGestureRecognizerDelegate>

@property(nonatomic,strong) UITextField *activeTextField;
@property(nonatomic,strong) UIView *targetView;

@property(nonatomic) CGPoint defaultPoint;
@property(nonatomic) CGFloat currentKeyboardHeight;
@property(nonatomic) BOOL isKeyboardAnimated;

-(void)setDefaultPoint:(CGPoint)defaultPoint;
-(void)updateContentsize:(CGSize)size;
-(void)updateDefaultPoint;

-(void) hideKeyboard;
-(void) keyboardWillShow:(NSNotification *)aNotification;
-(void) keyboardWillHide:(NSNotification *)aNotification;
-(void) keyboardWillShowWithLastKeyboardHeight;
-(void) keyboardShowWithkeyboardHeight:(CGFloat)keyboardHeight;


-(void) textFieldDidBeginEditing:(UITextField *)textField;
@end

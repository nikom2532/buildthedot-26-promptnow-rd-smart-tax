//
//  KeyboardViewController.m
//
//  Created by MECHIN on 10/25/2556 BE.
//  Copyright (c) 2556 buildthedot. All rights reserved.
//

#import "KeyboardViewController.h"

@interface KeyboardViewController ()

@end

#define textFieldMargin 0
#define _iOSVersion [UIDevice currentDevice].systemVersion.floatValue

@implementation KeyboardViewController{
    BOOL isFirstLoad;
    CGSize contentsize;
    CGFloat currentOriginY;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    isFirstLoad=YES;
    
    UITapGestureRecognizer *hideKeyboardGesture =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hideKeyboard)];
    
    [hideKeyboardGesture setDelegate:self];
    contentsize =CGSizeZero;
    [[self view] addGestureRecognizer:hideKeyboardGesture];
    [self setTargetView:[self view]];
    
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerNotificationForKeyboard];
}
-(void)viewDidAppear:(BOOL)animated{
    if (isFirstLoad) {
        isFirstLoad =NO;
    }
    for (UIGestureRecognizer *gesture in self.view.gestureRecognizers) {
        [gesture setDelegate:self];
    }
    if([self targetView].class == [UIScrollView class]){
        UIScrollView *scrollView = (UIScrollView*)[self targetView];
        [scrollView setDelegate:self];
        self.defaultPoint = [scrollView contentOffset];
    }else{
        self.defaultPoint = [self targetView].frame.origin;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self unregisterNotificationForKeboard];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma  mark - notification center
-(void)registerNotificationForKeyboard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}
-(void)unregisterNotificationForKeboard{
    NSNotificationCenter *nc =[NSNotificationCenter defaultCenter];
    [nc removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [nc removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    
}
#pragma mark - setting size
-(void)updateDefaultPoint{
    if( [[self targetView] isMemberOfClass:[UIScrollView class]]){
        UIScrollView *target = (UIScrollView*)[self targetView];
        self.defaultPoint = target.contentOffset;
    }
}
-(void)updateContentsize:(CGSize)size{
    contentsize =size;
    
}
#pragma mark - txtFieldDelegate
-(void) textFieldDidBeginEditing:(UITextField *)textField{
    BOOL needAdjustKeyboard = NO;
    if(self.activeTextField){
        needAdjustKeyboard = [self.activeTextField keyboardType] == [textField keyboardType];
    }
    self.activeTextField = textField;
    if(needAdjustKeyboard){
        [self keyboardWillShowWithLastKeyboardHeight];
    }
    
}
#pragma mark - keyboard

-(void) keyboardWillShow:(NSNotification *)aNotification{
    NSDictionary *keyboardInfo =[aNotification userInfo];
    NSValue *keyboardFrameBegin =[keyboardInfo valueForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect =[keyboardFrameBegin CGRectValue];
    [self setCurrentKeyboardHeight:keyboardRect.size.height];
    [self keyboardWillShowWithLastKeyboardHeight];
}
-(void)keyboardWillShowWithLastKeyboardHeight{
    [self keyboardShowWithkeyboardHeight:self.currentKeyboardHeight];
}
-(void) keyboardShowWithkeyboardHeight:(CGFloat)keyboardHeight{
    self.isKeyboardAnimated =YES;
    CGFloat frameMargin = 0;
    CGPoint focusTextPoint = [self.activeTextField convertPoint:self.activeTextField.bounds.origin toView:nil];
    CGFloat textfieldHeight = focusTextPoint.y + self.activeTextField.bounds.size.height;
    CGFloat windowHeight = [UIScreen mainScreen].bounds.size.height;
    
    if((windowHeight - textfieldHeight) < keyboardHeight )
    {
        frameMargin = (keyboardHeight - (windowHeight - textfieldHeight)) + textFieldMargin;
        
        if(frameMargin < 0){
            frameMargin = 0;
        }
        
    }
    
    if([self targetView].class == [UIScrollView class]){
        
        
        UIScrollView *scrollView = (UIScrollView*) [self targetView];
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0);
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
        
        // If active text field is hidden by keyboard, scroll it so it's visible
        // Your application might not need or want this behavior.
        
        //        CGRect aRect = CGRectMake(scrollView.frame.origin.x,scrollView.contentOffset.y, scrollView.frame.size.width, scrollView.frame.size.height - keyboardHeight);
        CGRect aRect = [scrollView convertRect:scrollView.bounds toView:nil];
        aRect.size.height -= keyboardHeight;
        
        
        if (!CGRectContainsPoint(aRect, CGPointMake(focusTextPoint.x, focusTextPoint.y + self.activeTextField.frame.size.height)) ) {
            CGPoint textFieldPoint = [scrollView convertPoint:focusTextPoint fromView:nil];
            CGPoint scrollPoint  = CGPointMake(0.0, (textFieldPoint.y - (scrollView.frame.size.height - keyboardHeight)) + self.activeTextField.frame.size.height);
            if (_iOSVersion < 6) {
                if(textFieldPoint.y + self.activeTextField.frame.size.height > scrollView.contentOffset.y + scrollView.frame.size.height){
                    scrollPoint.y -= scrollView.contentSize.height - (scrollView.contentOffset.y + scrollView.frame.size.height);
                }
            }
            
            [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                [scrollView setContentOffset:scrollPoint animated:NO];
            } completion:NO];
            
        }else if (!CGRectContainsPoint(aRect, focusTextPoint)){
            if (_iOSVersion >= 6) {
                CGPoint textFieldPoint = [scrollView convertPoint:focusTextPoint fromView:nil];
                CGPoint scrollPoint = CGPointMake(0, textFieldPoint.y);
                
                [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                    [scrollView setContentOffset:scrollPoint animated:NO];
                } completion:NO];
            }
        }
        self.isKeyboardAnimated = NO;
        
    }else{
        
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self targetView].frame = CGRectMake([self targetView].frame.origin.x,
                                                 [self targetView].frame.origin.y-frameMargin,
                                                 [self targetView].frame.size.width,
                                                 [self targetView].frame.size.height);
        } completion:^(BOOL finish){
            if(finish){
                self.isKeyboardAnimated = NO;
            }
        }];
    }

    
}
-(void) keyboardWillHide:(NSNotification *)aNotification{
    if([self targetView].class == [UIScrollView class]){
        
        UIScrollView *scrollView = (UIScrollView*) [self targetView];
        
        UIEdgeInsets contentInsets = UIEdgeInsetsZero;
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            scrollView.contentInset = contentInsets;
            scrollView.scrollIndicatorInsets = contentInsets;
        } completion:^(BOOL finish){
            if(finish){
                self.activeTextField = nil;
            }
        }];
        
        
        
    }else{
        [UIView animateWithDuration:0.3 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            [self targetView].frame = CGRectMake(self.defaultPoint.x,
                                                 self.defaultPoint.y,
                                                 [self targetView].frame.size.width,
                                                 [self targetView].frame.size.height);
        } completion:nil];
    }
    
}

-(void)hideKeyboard{
    if ([self activeTextField]) {
        if ([[self activeTextField] isFirstResponder]) {
            [[self activeTextField] resignFirstResponder];
        }
    }
    
}

#pragma mark - scrollView delegate
-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    self.defaultPoint = CGPointMake(targetContentOffset->x, targetContentOffset->y);
}
@end

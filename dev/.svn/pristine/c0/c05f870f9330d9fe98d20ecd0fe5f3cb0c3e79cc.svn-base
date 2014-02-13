//
//  ActivityAlertView.m
//  JOBBKK
//
//  Created by Promptnow on 12/25/13.
//  Copyright (c) 2013 Promptnow. All rights reserved.
//

#import "ActivityAlertView.h"

@implementation ActivityAlertView

@synthesize activityView;
- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame]))
	{
        self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(125, 80, 30, 30)];
        
        self.title = @"RD Loading";
        
        self.message = @"Please Wait....";
        [self addSubview:activityView];
        activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
        [activityView startAnimating];
		
//        if ([[[ShareObject sharedDataObject]  callShow] isEqualToString: @"notShow"]) {
//           
//        }else{
//           
//        }
        
        //[[NSTimer scheduledTimerWithTimeInterval:60.0 target:self selector:@selector(alertViewTimeOut:) userInfo:nil repeats:NO] retain];
    }
	
    return self;
}

- (void) show
{
    [super show];
    [self performSelector:@selector(closeLoading) withObject:nil afterDelay:30.0];
}

- (void)closeLoading
{
    [self dismissWithClickedButtonIndex:0 animated:YES];
}

- (void) close
{
	[self dismissWithClickedButtonIndex:0 animated:YES];
    
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
}

- (void) alertViewTimeOut:(id)sender {
    [self close];
}


@end

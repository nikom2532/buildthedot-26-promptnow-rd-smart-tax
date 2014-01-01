//
//  EfilingPrintDetailViewController.h
//  RDSmartTax
//
//  Created by fone on 12/16/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>

@interface EfilingPrintDetailViewController : HeaderViewController <UIWebViewDelegate, MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIView *pHeaderView;
@property (weak, nonatomic) IBOutlet UIButton *btnSave;
@property (weak, nonatomic) IBOutlet UIButton *btnEmail;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) NSString *pUrl;

- (IBAction)onSaveButtonClicked:(id)sender;
- (IBAction)onEmailButtonClicked:(id)sender;

@property (nonatomic, weak) NSString *pFormType;
@property (nonatomic, weak) NSString *pYear;
@property (nonatomic, weak) NSString *pNid;
@property (nonatomic, weak) NSString *pRefNo;

-(void)displayComposePage;

@end

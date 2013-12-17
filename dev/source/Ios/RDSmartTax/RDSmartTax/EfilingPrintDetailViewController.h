//
//  EfilingPrintDetailViewController.h
//  RDSmartTax
//
//  Created by fone on 12/16/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EfilingPrintDetailViewController : UIViewController <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (nonatomic, weak) NSString *pUrl;
@end

//
//  SettingMainViewController.h
//  RDSmartTax
//
//  Created by fone on 12/19/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingMainViewController : HeaderViewController
@property (weak, nonatomic) IBOutlet UILabel *lblLanguage;
@property (weak, nonatomic) IBOutlet UIButton *btnThai;
@property (weak, nonatomic) IBOutlet UIButton *btnEnglish;
- (IBAction)onThaiButtonClicked:(id)sender;
- (IBAction)onEnglishButtonClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *pHeaderView;

@end

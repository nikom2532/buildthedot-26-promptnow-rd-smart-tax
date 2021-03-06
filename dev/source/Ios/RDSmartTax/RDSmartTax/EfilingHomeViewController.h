//
//  EfilingHomeViewController.h
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ENCheckTemptaxform.h"
#import "ENLogoutService.h"
#import "KeyboardViewController.h"
@interface EfilingHomeViewController : HeaderViewController <ENCheckTemptaxformDelegate, ENLogoutServiceDelegate>{
}

@property (weak, nonatomic) IBOutlet UIView *pHeaderView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UILabel *lbLatestLogin;
@property (strong, nonatomic) IBOutlet UILabel *lbLoginTitle;
- (IBAction)onLogoutButtonClicked:(id)sender;

- (IBAction)onBackToMainMenuButtonClicked:(id)sender;
@property (nonatomic)ENCheckTemptaxform *engetForm;
@property (nonatomic)ENLogoutService *enLogoutService;
@end

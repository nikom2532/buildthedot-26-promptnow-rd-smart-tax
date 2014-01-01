//
//  EfilingHomeViewController.h
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EfilingHomeViewController : HeaderViewController {
}

@property (weak, nonatomic) IBOutlet UIView *pHeaderView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *lbName;
@property (strong, nonatomic) IBOutlet UILabel *lbLatestLogin;
@property (strong, nonatomic) IBOutlet UILabel *lbLoginTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSetting;


@end

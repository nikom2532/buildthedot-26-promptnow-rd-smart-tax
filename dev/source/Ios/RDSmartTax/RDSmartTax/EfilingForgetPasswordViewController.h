//
//  EfilingForgetPasswordViewController.h
//  RDSmartTax
//
//  Created by Noi on 12/16/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KeyboardViewController.h"
#import "ENResetPasswordRequestService.h"

@interface EfilingForgetPasswordViewController : KeyboardViewController<UITextFieldDelegate,UIGestureRecognizerDelegate,ENResetPasswordRequestServiceDelegate,UITableViewDelegate,UITableViewDataSource>{

UITextField *txtActiveEditing;
UITextField* birthDateField_;

}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,copy) NSString* pNid;
@property (nonatomic,copy) NSString* birthDate;
@property (nonatomic,copy) NSString* version;

@end

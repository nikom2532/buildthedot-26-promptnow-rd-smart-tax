//
//  AllServiceViewController.h
//  RDSmartTax
//
//  Created by fone on 1/14/57 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PagedFlowView.h"
#import "KeyboardViewController.h"
#import "ENCheckNewUserService.h"
#import <MapKit/MapKit.h>

@interface AllServiceViewController : KeyboardViewController <UITextFieldDelegate, ENCheckNewUserServiceDelegate, PagedFlowViewDelegate,PagedFlowViewDataSource, MKMapViewDelegate, CLLocationManagerDelegate>

//-- e filing
@property (nonatomic, retain) NSArray *locationArray;
@property (nonatomic) ENCheckNewUserService *enCheckNewUserService;

//-- map
@property (nonatomic, retain) CLLocationManager *locationManager;

//-- page flow
- (IBAction)pageControlValueDidChange:(id)sender;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet PagedFlowView *pageFlowView;
- (IBAction)onSettingButtonClicked:(id)sender;

@end

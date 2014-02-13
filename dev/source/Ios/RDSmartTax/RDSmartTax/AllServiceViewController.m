//
//  AllServiceViewController.m
//  RDSmartTax
//
//  Created by fone on 1/14/57 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import "AllServiceViewController.h"
#import "MainPageFlowView.h"
#import "NewsView.h"
#import "EbookView.h"
#import "EfilingView.h"
#import "MapView.h"
#import "FontUtil.h"
#import "SettingMainViewController.h"
#import "MapSearchViewController.h"

@interface AllServiceViewController () {
    
    //-- view
    NewsView *newsView;
    EbookView *ebookView;
    EfilingView *efilingView;
    MapView *mapView;
    
    //-- page flow
    MainPageFlowView *mainPageFlowView;
    NSMutableArray *tempView;
    
    //-- efiling
    UITextField *activeTextField;
    CGRect originScrollViewFrame;
    CGSize contentsize;
    int maxLength;
    
    CGFloat screenHeight;
}

@end

@implementation AllServiceViewController

@synthesize enCheckNewUserService;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    [self.pageFlowView reloadData];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;

    self.pageFlowView.delegate = self;
    self.pageFlowView.dataSource = self;
    self.pageFlowView.pageControl = self.pageControl;
    self.pageFlowView.minimumPageAlpha = 0.3;
    self.pageFlowView.minimumPageScale = 0.9;
    
    //-- map
    // set location tracking system
	self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = 10.0; // min distance resolution for update , 10 m call
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // Type auto-complete "kCLLocation" to more choice // ความแม่นยำม ความละเอียด
   	[self.locationManager startUpdatingLocation]; // start update
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - page flow delegate
- (CGSize)sizeForPageInFlowView:(PagedFlowView *)flowView;{
    if (OSVersionIsAtLeastiOS7) {
        return CGSizeMake(320, screenHeight);
    }
    return CGSizeMake(320, screenHeight-15);
}

- (void)flowView:(PagedFlowView *)flowView didScrollToPageAtIndex:(NSInteger)index {
    if (index!=-1) {
        
    }
}

- (void)flowView:(PagedFlowView *)flowView didTapPageAtIndex:(NSInteger)index{
    
}

#pragma mark PagedFlowView Datasource
- (NSInteger)numberOfPagesInFlowView:(PagedFlowView *)flowView{
    return 4;
}

- (UIView *)flowView:(PagedFlowView *)flowView cellForPageAtIndex:(NSInteger)index{
    
    mainPageFlowView = [Util loadViewWithNibName:@"MainPageFlowView"];
    
    if (index==0) {
        [mainPageFlowView.pHeader addSubview:[self loadHeaderWithHeaderPicName:@"bg_green.png" logoName:@"logo_efiling.png"]];
        [mainPageFlowView.pContent addSubview:[self loadNewsView]];
        mainPageFlowView.pFooter.image = [UIImage imageNamed:@"bg_green.png"];
        
    } else if (index==1) {
        [mainPageFlowView.pHeader addSubview:[self loadHeaderWithHeaderPicName:@"bg_green.png" logoName:@"logo_efiling.png"]];
        [mainPageFlowView.pContent addSubview:[self loadEbookView]];
        mainPageFlowView.pFooter.image = [UIImage imageNamed:@"bg_green.png"];
        
    } else if (index==2) {
        [mainPageFlowView.pHeader addSubview:[self loadHeaderWithHeaderPicName:@"bg_green.png" logoName:@"logo_efiling.png"]];
        [mainPageFlowView.pContent addSubview:[self loadEfilingView]];
        mainPageFlowView.pFooter.image = [UIImage imageNamed:@"bg_green.png"];
        
    } else {
        [mainPageFlowView.pHeader addSubview:[self loadHeaderWithHeaderPicName:@"bg_green.png" logoName:@"logo_efiling.png"]];
        [mainPageFlowView.pContent addSubview:[self loadMapView]];
        mainPageFlowView.pFooter.image = [UIImage imageNamed:@"bg_green.png"];
    }
    return mainPageFlowView;
}
#pragma mark - LOAD HEADER
- (Header *) loadHeaderWithHeaderPicName: (NSString *) headerPicName logoName : (NSString *) logoName {
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:headerPicName]];
    header.pImage.image = [UIImage imageNamed:logoName];
    header.pLabel.hidden = YES;
    header.pLeftButton.hidden = YES;
    header.pRightButton.hidden = YES;
    return header;
}

#pragma mark - LOAD NEWS
- (NewsView *) loadNewsView {
    newsView = [Util loadViewWithNibName:@"NewsView"];
    return newsView;
}

#pragma mark - LOAD EBOOK
- (EbookView *) loadEbookView {
    ebookView = [Util loadViewWithNibName:@"EbookView"];
    return ebookView;
}

#pragma mark - LOAD EFILING
- (EfilingView *) loadEfilingView {
    
    efilingView = [Util loadViewWithNibName:@"EfilingView"];
    
    //-- set language
    [efilingView.labelTitle1 setText:[Util stringWithScreenName:@"Login" labelName:@"Title1"]];
    [efilingView.labelTitle2 setText:[Util stringWithScreenName:@"Login" labelName:@"Title2"]];
    [efilingView.labelTitle3 setText:[Util stringWithScreenName:@"Login" labelName:@"Title3"]];
    [efilingView.tvDetail setText:[Util stringWithScreenName:@"Login" labelName:@"Detail"]];
    [efilingView.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
    
    //-- set font
    [efilingView.labelTitle1 setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    [efilingView.labelTitle2 setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [efilingView.labelTitle3 setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [efilingView.tvDetail setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [efilingView.txtIdCard setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [efilingView.btnLogin.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    return efilingView;
}
#pragma mark - LOAD MAP
- (MapView *) loadMapView {
    mapView = [Util loadViewWithNibName:@"MapView"];
    mapView.pMap.delegate = self;
    mapView.pMap.showsUserLocation=TRUE;
    [mapView.btnCurrentPosition addTarget:self action:@selector(onBtnCurrentPositionClicked:) forControlEvents:UIControlEventTouchUpInside];
    [mapView.btnSearch addTarget:self action:@selector(onBtnSearchClicked:) forControlEvents:UIControlEventTouchUpInside];
    return mapView;
}

-(IBAction)onBtnCurrentPositionClicked:(id)sender {
    [mapView.pMap setRegion:MKCoordinateRegionMake([mapView.pMap.userLocation coordinate], MKCoordinateSpanMake(0.001, 0.001)) animated:YES];
}

-(IBAction)onBtnSearchClicked:(id)sender {
    MapSearchViewController *mapSearch = [[MapSearchViewController alloc]initWithNibName:@"MapSearchViewController" bundle:nil];
    [self.navigationController pushViewController:mapSearch animated:YES];
}


#pragma mark - action

- (IBAction)pageControlValueDidChange:(id)sender {
}
- (IBAction)onSettingButtonClicked:(id)sender {
    SettingMainViewController *setting = [[SettingMainViewController alloc]initWithNibName:@"SettingMainViewController" bundle:nil];
    [self.navigationController pushViewController:setting animated:YES];
}
@end

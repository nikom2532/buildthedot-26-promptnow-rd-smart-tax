//
//  EfilingTaxPaymentOtherViewController.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/31/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingTaxPaymentOtherViewController.h"
#import "JLString.h"
#import "AQGridView.h"
#import "PaymentGridViewCell.h"
#import "FontUtil.h"
#import "PaymentPayinSlipViewController.h"
#define titleBarHeight 65
#define footerHeight 0
@interface EfilingTaxPaymentOtherViewController ()<AQGridViewDataSource,AQGridViewDelegate>
{
    NSMutableArray *atmArray;
    
    CGFloat screenHeight;

}
@property (retain, nonatomic) AQGridView *gridView;

@end

@implementation EfilingTaxPaymentOtherViewController

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
//    self.title = @"ช่องทางการชำระภาษี";

    CGRect screenRect = [[UIScreen mainScreen] bounds];
    screenHeight = screenRect.size.height;
    
    JLLog(@"_resposeData : %@",_resposeData);
    // Do any additional setup after loading the view from its nib.
    atmArray = [[NSMutableArray alloc]init];
//    [atmArray addObject:@"TMB"];
//    [atmArray addObject:@"KTB"];
//    [atmArray addObject:@"SCB"];
//    [atmArray addObject:@"UOB"];
//    [atmArray addObject:@"CIMB"];
//    [atmArray addObject:@"HSBC"];

    if ([[JLString removeNullString:[_resposeData objectForKey:@"label"]]hasPrefix:@"Counter"]) {
        payinslipButton.hidden = NO;
    }
    else if (![[JLString removeNullString:[_resposeData objectForKey:@"label"]]hasPrefix:@"Counter"])
    {
        payinslipButton.hidden = YES;
    }
    [atmArray addObjectsFromArray:[_resposeData objectForKey:@"logos"]];
    [self createGridview];
    [self setFontStyle];
    [self createHeaderInview];
}
- (void) createHeaderInview
{
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.text = @"ช่องทางการชำระภาษี";
    [self.header.pLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
}
- (void) setFontStyle {
    
   
    [headerLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
    [taxidHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [taxidLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [amountHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [amountLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [controlHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [controlLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [footerLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - GridView
-(void)createGridview
{
    
    _gridView = [[AQGridView alloc]init];
    [_gridView setDelegate:self];
    [_gridView setDataSource:self];
    [_gridView setBackgroundColor:[UIColor clearColor]];
    [_gridView setFrame:CGRectMake(0,footerLabel.frame.size.height+footerLabel.frame.origin.y, self.view.frame.size.width,128)];//screenHeight-footerHeight-titleBarHeight)];
    [self.view addSubview:_gridView];
    
    [_gridView reloadData];
    
}

-(NSUInteger)numberOfItemsInGridView:(AQGridView *)gridView
{
    return atmArray.count;
}

-(CGSize)portraitGridCellSizeForGridView:(AQGridView *)gridView
{
    
    return CGSizeMake(60, 60);
}

-(AQGridViewCell*)gridView:(AQGridView *)gridView cellForItemAtIndex:(NSUInteger)index
{
    static NSString *cellIdentifier = @"Cell";
    //    AQGridViewCell *cell = nil;
    
    
    PaymentGridViewCell *atmlist = (PaymentGridViewCell*)[gridView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(atmlist == nil)
    {
        atmlist = [[PaymentGridViewCell alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0) reuseIdentifier:cellIdentifier];
    }
    [atmlist.contentView setBackgroundColor:[UIColor clearColor]];
    //    [newsGrid.BGImg setImage:[UIImage imageNamed:@"bg_podcast.png"]];
    //
    
    JLLog(@"%@",[atmArray objectAtIndex:index]);
    [atmlist.BankImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@.gif",[atmArray objectAtIndex:index]]]];
    //
    //    newsGrid.timeLabel.text = [NSString stringWithFormat:@"%@\n%@ min.",[JLString removeNullString:[[podCastDetail objectForKey:@"podcast"]objectForKey:@"datetime_podcast"]],[JLString removeNullString:[[podCastDetail objectForKey:@"podcast"]objectForKey:@"file_length"]]];
    //
    //
//    [atmlist.BankImg setImageWithURL:[NSURL URLWithString:[JLString removeNullString:[bookDetail objectForKey:@"book_cover"]]]];
    //    [booklist.CoverImg setImageWithURL:<#(NSURL *)#> placeholderImage:<#(UIImage *)#>
    //
    //    //    NSString *newsString = [[JLString removeNullString:[newsDetail objectForKey:@"news_title"]] stringByStrippingHTML];
    //
    //    [newsGrid setBackgroundColor:[UIColor clearColor]];
    
    //    newsGrid.titleLabel.textColor = [RSUColor newsTextColor];
    //    newsGrid.titleLabel.text = newsString;
    //    [newsGrid.titleImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[newsDetail objectForKey:@"news_picture"]]] placeholderImage:[UIImage imageNamed:@"placeholder"] success:^(UIImage *image){} failure:^(NSError *error) {}];
    //
    //    [newsGrid setBackgroundColor:[UIColor redColor]];
    
    return atmlist;
}
-(void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index
{
    
    //
    //    detailProductViewController *detailProduct = [[detailProductViewController alloc]initWithNibName:@"detailProductViewController" bundle:nil];
    //    [self.navigationController pushViewController:detailProduct animated:YES];
    //    [gridView deselectItemAtIndex:index animated:NO];
    
    //    NSDictionary *dic = [dataArray objectAtIndex:index];
    //    JLLog(@"%@",dic);
    //    [downloadArray addObject:dic];
    //    [downloadArray writeToFile:[self dataFilePathFavorite] atomically:YES];
    //
    //    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"" message:@"Download Success" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    //    [alert show];
    //    NSDictionary *detail = [dataArray objectAtIndex:index];
    
//    DetailViewController *detailVC = [[DetailViewController alloc]initWithNibName:@"DetailViewController" bundle:nil];
//    detailVC.recDictionary = [dataArray objectAtIndex:index];
//    [self.navigationController pushViewController:detailVC animated:YES];
    
    [gridView deselectItemAtIndex:index animated:YES];
    
}
#pragma mark - Category Scroll View
-(void)setScrollATMWithClickedIndex:(int)Index
{
    //    int bannerPage = (bannerArray.count+4-1)/4;
    //
    //    JLLog(@"Page = %d",bannerPage);
    
    float gapWidth = 10.0f;
    //    float bannerViewWidth = gapWidth+(menuArray.count*140)+(menuArray.count*gapWidth);
    float bannerViewWidth = gapWidth+(atmArray.count*90)+(atmArray.count*gapWidth);
    
    scrollviewATM.pagingEnabled = NO;
    //    scrollview.contentSize = CGSizeMake(bannerViewWidth, 60);
    [scrollviewATM setContentSize:CGSizeMake(bannerViewWidth, -20)];
    scrollviewATM.showsVerticalScrollIndicator = NO;
    scrollviewATM.showsHorizontalScrollIndicator = NO;
    scrollviewATM.scrollsToTop = NO;
    scrollviewATM.bounces = YES;
//    scrollviewATM.delegate = self;
    
    if(scrollviewATM.subviews.count > 0)
    {
        id bnView = [scrollviewATM.subviews objectAtIndex:0];
        
        if([bnView isKindOfClass:[UIView class]])
        {
            [bnView removeFromSuperview];
        }
    }
    
    float xOrigin = 10.0f;
    
    UIView *bannerView ;
    bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bannerViewWidth, scrollviewATM.frame.size.height)];

//    if(OSVersionIsAtLeastiOS7)
//    {
//        bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bannerViewWidth, scrollviewNewBook.frame.size.height)];
//    }
//    else if(!OSVersionIsAtLeastiOS7)
//    {
//        bannerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bannerViewWidth, scrollviewNewBook.frame.size.height)];
//        
//    }
    [bannerView setBackgroundColor:[UIColor clearColor]];
    //    for(int bannerCount = 0 ; bannerCount < menuArray.count ; bannerCount++)
    for(int bannerCount = 0 ; bannerCount < atmArray.count; bannerCount++)
        
    {
        //        NSDictionary *tempBannerDetail = [menuArray objectAtIndex:bannerCount];
        
        CGRect frame = CGRectMake(xOrigin, 0, 90, 100);
        
        /*
         UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
         [imageView setContentMode:UIViewContentModeScaleToFill];
         [imageView setImageWithURL:[NSURL URLWithString:[JLString removeNullString:[tempBannerDetail objectForKey:@"program_thumbnail"]]] placeholderImage:[UIImage imageNamed:@"placeholder"]];
         [bannerView addSubview:imageView];
         */
        //        NSDictionary *dic = [menuArray objectAtIndex:bannerCount];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = frame;
        
        
        
        //        [button setTitle:[NSString stringWithFormat:@"%@",[dic objectForKey:@"cate_name"]] forState:UIControlStateNormal];
//        [button setImage:[UIImage imageNamed:@"asia.jpg"] forState:UIControlStateNormal];
        
        [button setTitle:[JLString removeNullString:[atmArray objectAtIndex:bannerCount]] forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor darkGrayColor]];
        [button setEnabled:YES];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //        [button addTarget:self action:@selector(headButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        //        [button addTarget:self action:@selector(headButtonClicked:) forControlEvents:UIControlEventTouchDown];
        button.tag = bannerCount;
        
        /*
         if(bannerCount == bannerIndex)
         {
         [button.layer setBorderColor:[[UIColor blueColor] CGColor]];
         [button.layer setBorderWidth:0.9];
         [button.layer setCornerRadius:3.0f];
         [button.layer setMasksToBounds:YES];
         }
         else
         {
         [button.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
         [button.layer setBorderWidth:0.6];
         [button.layer setCornerRadius:3.0f];
         [button.layer setMasksToBounds:YES];
         }
         */
        
        
        [bannerView addSubview:button];
        xOrigin = xOrigin+frame.size.width+gapWidth;
    }
    
    [scrollviewATM addSubview:bannerView];
}
- (IBAction)payinslipClicked:(id)sender {
    PaymentPayinSlipViewController *pay = [[PaymentPayinSlipViewController alloc]initWithNibName:@"PaymentPayinSlipViewController" bundle:nil];
    [self.navigationController pushViewController:pay animated:YES];
}
@end

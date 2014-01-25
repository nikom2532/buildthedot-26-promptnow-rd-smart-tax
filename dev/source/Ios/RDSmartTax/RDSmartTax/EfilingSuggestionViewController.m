//
//  EfilingSuggestionViewController.m
//  RDSmartTax
//
//  Created by fone on 12/22/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingSuggestionViewController.h"
#import "FontUtil.h"
#import "Util.h"
#import "ShareUserDetail.h"
#import "JSONDictionaryExtensions.h"
#import "SVProgressHUD.h"
#import "EfilingSuggestionTextDetailViewController.h"
#import "EfilingSuggestionWebViewDetailViewController.h"

@interface EfilingSuggestionViewController (){
    NSMutableArray *explanation_id;
    NSMutableArray *topic_name;
    NSMutableArray *instructions_id;
    NSMutableArray *instructions_name;
    NSMutableArray *instructionsImages;
    int currentIndex;
}

@end

@implementation EfilingSuggestionViewController
@synthesize enGetSuggestionTitle;

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
    
    instructionsImages = [[NSMutableArray alloc]initWithObjects:@"icon_suggestion_efiling.png",@"icon_suggestion_condition.png",@"icon_suggestion_agreement.png",@"icon_suggestion_time_extend.png", nil];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    enGetSuggestionTitle = [[ENGetSuggestionTitle alloc]init];
    enGetSuggestionTitle.delegate = self;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    if ([Util isInternetConnect]) {
        [self callSuggestionTitle];
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
    }
    
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    currentIndex = -1;
    [self.tableView reloadData];
    [self createHeader];
    
}
-(void) createHeader{
    self.navigationController.navigationBar.hidden = YES;
    Header *header = [Util loadViewWithNibName:@"Header"];
    header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    header.pLabel.text = [Util stringWithScreenName:@"Setting" labelName:@"Suggestion"];
    header.pLabel.font = [FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold];
    [header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    header.pRightButton.hidden = YES;
    [self.view addSubview:header];
    
}

-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [instructions_name count];//topic_name
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    
    cell.textLabel.text = [instructions_name objectAtIndex:indexPath.row];
    
    if([instructions_name objectAtIndex:3]){
        cell.textLabel.numberOfLines = 2;
    }
    cell.detailTextLabel.numberOfLines = 2;
    cell.detailTextLabel.text = @"เนื้อหาจำลองแบบเรียบๆ ที่ใช้กันในธุรกิจงานพิมพ์หรืองานเรียงพิมพ์";
    cell.detailTextLabel.font = [FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleBold];
    cell.detailTextLabel.textColor = [UIColor blackColor];
    cell.imageView.image = [UIImage imageNamed:[instructionsImages objectAtIndex:indexPath.row]];
//
    UIView *bgColorView = [[UIView alloc] init];
    if (currentIndex==-1) {
         cell.imageView.image = [UIImage imageNamed:[instructionsImages objectAtIndex:indexPath.row]];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = [UIColor blackColor];
    } else {
        if (currentIndex==indexPath.row) {
            cell.imageView.image = [UIImage imageNamed:[instructionsImages objectAtIndex:indexPath.row]];
            cell.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_list_selection.png"]];
            cell.textLabel.textColor = [UIColor whiteColor];
        } else {
             cell.imageView.image = [UIImage imageNamed:[instructionsImages objectAtIndex:indexPath.row]];
            cell.backgroundColor = [UIColor clearColor];
            cell.textLabel.textColor = [UIColor blackColor];
        }
    }
    [bgColorView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_list_selection.png"]]];
    [cell setSelectedBackgroundView:bgColorView];
    
    UIImage *img = [UIImage imageNamed:@"bg_list_line.png.png"];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 100-img.size.height, img.size.width, img.size.height)];
    imv.image = img;
    [cell addSubview:imv];
    
    return cell;
    
}

- (void) callSuggestionTitle{
    [enGetSuggestionTitle requestENGetSuggestionTitleService];
}
-(void)responseENGetSuggestionTitleService:(NSData*)data{
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    //if ([[dic objectForKey:@"responseCode"] isEqualToString:@"0"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
//        explanation_id = [[NSMutableArray alloc]init];
//        topic_name = [[NSMutableArray alloc]init];
    
          instructions_id = [[NSMutableArray alloc]init];
          instructions_name = [[NSMutableArray alloc]init];

        NSEnumerator *enumerator = [responseDataDic objectEnumerator];
        id object;
        while (object = [enumerator nextObject]) {
            [instructions_id addObject:[object objectForKey:@"instructions_id"]];//explanation_id
            [instructions_name addObject:[object objectForKey:@"instructions_name"]];//topic_name
        }
       [instructions_name addObject:@"คำชี้แจงกรมสรรพากรเรื่องการขยายเวลา"];
    //}
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    currentIndex = indexPath.row;
    [self.tableView reloadData];
     EfilingSuggestionTextDetailViewController *vc = [[EfilingSuggestionTextDetailViewController alloc]initWithNibName:@"EfilingSuggestionTextDetailViewController" bundle:nil];
    
//    EfilingSuggestionWebViewDetailViewController *vc = [[EfilingSuggestionWebViewDetailViewController alloc]initWithNibName:@"EfilingSuggestionWebViewDetailViewController" bundle:nil];


    vc.pId = [instructions_id objectAtIndex:indexPath.row];//explanation_id
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

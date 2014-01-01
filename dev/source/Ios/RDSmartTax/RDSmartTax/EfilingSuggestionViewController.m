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
    ENGetSuggestionTitle *enGetSuggestionTitle;
    NSMutableArray *instructionsId;
    NSMutableArray *instructionsName;
    NSMutableArray *instructionsImages;
    int currentIndex;
}

@end

@implementation EfilingSuggestionViewController

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
    
    instructionsImages = [[NSMutableArray alloc]initWithObjects:@"correct.png",@"correct.png",@"correct.png", nil];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    
    enGetSuggestionTitle = [[ENGetSuggestionTitle alloc]init];
    enGetSuggestionTitle.delegate = self;
    
    [self callSuggestionTitle];

    //-- Header
    self.header.pView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"bg_green.png"]];
    self.header.pImage.image = [UIImage imageNamed:@"icon_efiling.png"];
    self.header.pLabel.hidden = YES;
    [self.header.pLeftButton addTarget:self action:@selector(onBackBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.header.pRightButton.hidden = YES;
    [self.pHeaderView addSubview:self.header];
}
- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    currentIndex = -1;
    [self.tableView reloadData];
}
-(IBAction)onBackBtnClicked:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Table view data source
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [instructionsName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    cell.textLabel.font = [FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal];
    
    cell.textLabel.text = [instructionsName objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:[instructionsImages objectAtIndex:indexPath.row]];
//
    UIView *bgColorView = [[UIView alloc] init];
    if (currentIndex==-1) {
         cell.imageView.image = [UIImage imageNamed:[instructionsImages objectAtIndex:indexPath.row]];        cell.backgroundColor = [UIColor clearColor];
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
    
    //    UIImage *img;
    //    if (indexPath.row==1||indexPath.row==4) {
    //        img = [UIImage imageNamed:@"bg_list_section_separate.png"];
    //    } else {
    //        img = [UIImage imageNamed:@"bg_list_line.png.png"];
    //    }
    
    UIImage *img = [UIImage imageNamed:@"bg_list_line.png.png"];
    UIImageView *imv = [[UIImageView alloc]initWithFrame:CGRectMake(0, 50-img.size.height, img.size.width, img.size.height)];
    imv.image = img;
    [cell addSubview:imv];
    
    return cell;

    
}

- (void) callSuggestionTitle{
    [enGetSuggestionTitle requestENGetSuggestionTitleService];
}
-(void)responseENGetSuggestionTitleService:(NSData*)data{
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    if ([[dic objectForKey:@"responseStatus"] isEqualToString:@"SUCCESS"]) {
        NSDictionary *responseDataDic = [dic objectForKey:@"responseData"];
        NSString *responseCode = [dic objectForKey:@"responseCode"];
        NSLog(@"rescode %@",responseCode);
        instructionsId = [[NSMutableArray alloc]init];
        instructionsName = [[NSMutableArray alloc]init];
        NSEnumerator *enumerator = [responseDataDic objectEnumerator];
        id object;
        while (object = [enumerator nextObject]) {
            [instructionsId addObject:[object objectForKey:@"instructions_id"]];
            [instructionsName addObject:[object objectForKey:@"instructions_name"]];
        }
    }else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Common" labelName:@"Sorry"] msg:[dic objectForKey:@"responseError"]];
    }
    [self.tableView reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    currentIndex = indexPath.row;
    [self.tableView reloadData];
     EfilingSuggestionTextDetailViewController *vc = [[EfilingSuggestionTextDetailViewController alloc]initWithNibName:@"EfilingSuggestionTextDetailViewController" bundle:nil];
    
    //EfilingSuggestionWebViewDetailViewController *vc = [[EfilingSuggestionWebViewDetailViewController alloc]initWithNibName:@"EfilingSuggestionWebViewDetailViewController" bundle:nil];


    vc.pId = [instructionsId objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
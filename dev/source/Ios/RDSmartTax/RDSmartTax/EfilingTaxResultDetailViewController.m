//
//  EfilingTaxResultDetailViewController.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 12/22/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "EfilingTaxResultDetailViewController.h"
#import "FontUtil.h"
#import "JLString.h"
#import "DetailCell.h"
#import "DetailExpandCell.h"
#import "DetailNolineCell.h"
@interface EfilingTaxResultDetailViewController ()
{
    NSMutableArray *selectionCell;
}
@end

@implementation EfilingTaxResultDetailViewController

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
    self.title = @"รายละเอียดการยื่นภาษี";
//    [scrollview addSubview:detailview];
    selectionCell = [[NSMutableArray alloc]init];

    [self setFontStyle];
    [self setLanguage];
    [self createHeaderInview];
    
    headerLabel.text = @"รายละเอียดค่าลดหย่อน";
    [headerLabel setFont:[FontUtil fontWithFontSize:eFontSizeSmall Style:eFontStyleNormal]];
}
- (void) createHeaderInview
{
    self.header.pImage.hidden = YES;
    self.header.pLabel.hidden = NO;
    self.header.pLabel.text = @"ยื่นภาษี";
    [self.header.pLabel setFont:[FontUtil fontWithFontSize:eFontSizeBig Style:eFontStyleBold]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma - Decorate Label
- (void) setLanguage {
    //    [self.titlesetText:[Util stringWithScreenName:@"Login" labelName:@"EfilingTitle"]];
    //    [self.labelIdCard setText:[Util stringWithScreenName:@"Login" labelName:@"Nid"]];
    //    [self.btnLogin setTitle:[Util stringWithScreenName:@"Login" labelName:@"Title"] forState:UIControlStateNormal];
}

- (void) setFontStyle {
    
    [salaryHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [salaryLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [incomeButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [discountButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];
    [donateButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleBold]];

    [incomeunlessHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [incomeunlessLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [expensesHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [expensesLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [reduceHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [reduceLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [reduceDetailButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [donateDetailButton.titleLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [donateHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [donateLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

    [netHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [netLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    
    [taxOfNetHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
    [taxOfNetLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
}
#pragma mark - Action Method
- (IBAction)incomeDetailClicked:(UIButton *)sender {
}

- (IBAction)expensesDetailClicked:(UIButton *)sender {
}

- (IBAction)donateDetailClicked:(UIButton *)sender {
}

#pragma mark - UITABLEVIEW DELEGATE
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int cSelection = 0; cSelection < selectionCell.count; cSelection++) {
        if ([[JLString removeNullString:[selectionCell objectAtIndex:cSelection]]isEqualToString:[NSString stringWithFormat:@"%d",indexPath.row]]) {
            return 225;
        }
    }
    return 89.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
//	cell.selectionStyle = UITableViewCellSelectionStyleNone;
   
//    if (selectedRow == indexPath.row)
//    {
//        
//    }
    if (indexPath.row >= 0 && indexPath.row <=1) {
        if (selectionCell.count == 0) {
            DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil];
                
                for(id oneObject in nib)
                {
                    if([oneObject isKindOfClass:[DetailCell class]])
                    {
                        cell = (DetailCell *)oneObject;
                    }
                }
            }
            
            [cell.detailHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            [cell.detailDLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            [cell.detail2HLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            [cell.detail2DLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            
            [cell.footerLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

            if (indexPath.row == 0) {
                cell.detailHLabel.text = @"เงินเดือน ค่าจ้าง บำนาญ";
                cell.detailDLabel.text = @"2,330,000.00";
                cell.detail2HLabel.text = @"เงินได้ที่ได้รับการยกเว้น";
                cell.detail2DLabel.text = @"330,000.00";
                cell.footerLabel.text = @"รายละเอียดเงินได้ที่ได้รับการยกเว้น";

            }
            if (indexPath.row == 1) {
//                cell.detailHLabel.text = @"ค่าลดหย่อน";
//                cell.detailDLabel.text = @"20,000.00";
//                cell.footerLabel.text = @"รายละเอียดค่าลดหย่อน";
                
                cell.detailHLabel.text = @"ค่าใช้จ่าย";
                cell.detailDLabel.text = @"60,000.00";
                cell.detail2HLabel.text = @"ค่าลดหย่อน";
                cell.detail2DLabel.text = @"380,000.00";
                cell.footerLabel.text = @"รายละเอียดค่าลดหย่อน";
                
            }
            return cell;
        }
        else if (selectionCell.count != 0) {
            for (int cSelection = 0; cSelection < selectionCell.count; cSelection++) {
                if ([[JLString removeNullString:[selectionCell objectAtIndex:cSelection]]isEqualToString:[NSString stringWithFormat:@"%d",indexPath.row]]) {
                    //            return 100;
                    DetailExpandCell *cell = (DetailExpandCell *)[tableView dequeueReusableCellWithIdentifier:@"detailExpandCell"];
                    
                    if(!cell)
                    {
                        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailExpandCell" owner:self options:nil];
                        
                        for(id oneObject in nib)
                        {
                            if([oneObject isKindOfClass:[DetailExpandCell class]])
                            {
                                cell = (DetailExpandCell *)oneObject;
                            }
                        }
                    }
                    [cell.detailHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.detailDLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.detail2HLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.detail2DLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    
                    [cell.footerLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    
                    [cell.d1HLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.d2HLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.d3HLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.d4HLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

                    [cell.d1Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.d2Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.d3Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
                    [cell.d4Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

                    if (indexPath.row == 0) {
                        cell.detailHLabel.text = @"เงินเดือน ค่าจ้าง บำนาญ";
                        cell.detailDLabel.text = @"2,330,000.00";
                        cell.detail2HLabel.text = @"เงินได้ที่ได้รับการยกเว้น";
                        cell.detail2DLabel.text = @"330,000.00";
                        cell.footerLabel.text = @"รายละเอียดเงินได้ที่ได้รับการยกเว้น";

                        
                        cell.d1HLabel.text = @"เงินเดือน ค่าจ้าง บำนาญ";
                        cell.d2HLabel.text = @"ภาษีเงินได้หัก ณ ที่จ่าย";
                        cell.d3HLabel.hidden = YES;
                        cell.d4HLabel.hidden = YES;

                        cell.d1Label.text = @"360,000.00";
                        cell.d2Label.text = @"30,000.00";
                        cell.d3Label.hidden = YES;
                        cell.d4Label.hidden = YES;

                    }
                    if (indexPath.row == 1) {
                        cell.detailHLabel.text = @"ค่าใช้จ่าย";
                        cell.detailDLabel.text = @"60,000.00";
                        cell.detail2HLabel.text = @"ค่าลดหย่อน";
                        cell.detail2DLabel.text = @"380,000.00";
                        cell.footerLabel.text = @"รายละเอียดค่าลดหย่อน";
                        
                        cell.d1HLabel.text = @"ค่าลดหย่อนผู้มีเงินได้";
                        cell.d2HLabel.text = @"ค่าลดหย่อนคู่สมรส";
                        cell.d3HLabel.text = @"ค่าลดหย่อนบุตรไม่ศึกษา";
                        cell.d4HLabel.text = @"ค่าลดหย่อนบุตรศึกษา";


                        cell.d1Label.text = @"15,000.00";
                        cell.d2Label.text = @"5,000.00";
                        cell.d3Label.text = @"5,000.00";
                        cell.d4Label.text = @"10,000.00";

                    }

                    return cell;
                }
                //            else
                //            {
                //
                //            }
            }
            DetailCell *cell = (DetailCell *)[tableView dequeueReusableCellWithIdentifier:@"detailCell"];
            
            if(!cell)
            {
                NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil];
                
                for(id oneObject in nib)
                {
                    if([oneObject isKindOfClass:[DetailCell class]])
                    {
                        cell = (DetailCell *)oneObject;
                    }
                }
            }
            [cell.detailHLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            [cell.detailDLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            [cell.footerLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            [cell.detail2HLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            [cell.detail2DLabel setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
            
            if (indexPath.row == 0) {
                cell.detailHLabel.text = @"เงินเดือน ค่าจ้าง บำนาญ";
                cell.detailDLabel.text = @"2,330,000.00";
                cell.detail2HLabel.text = @"เงินได้ที่ได้รับการยกเว้น";
                cell.detail2DLabel.text = @"330,000.00";
                cell.footerLabel.text = @"รายละเอียดเงินได้ที่ได้รับการยกเว้น";
                

                
            }
            if (indexPath.row == 1) {
                cell.detailHLabel.text = @"ค่าใช้จ่าย";
                cell.detailDLabel.text = @"60,000.00";
                cell.detail2HLabel.text = @"ค่าลดหย่อน";
                cell.detail2DLabel.text = @"380,000.00";
                cell.footerLabel.text = @"รายละเอียดค่าลดหย่อน";
            }

            return cell;
        }

    }
    else
    {
        DetailNolineCell *cell = (DetailNolineCell *)[tableView dequeueReusableCellWithIdentifier:@"detailNolineCell"];
        
        if(!cell)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailNolineCell" owner:self options:nil];
            
            for(id oneObject in nib)
            {
                if([oneObject isKindOfClass:[DetailNolineCell class]])
                {
                    cell = (DetailNolineCell *)oneObject;
                }
            }
        }
        [cell.header1Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
        [cell.header2Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
        [cell.detail1Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];
        [cell.detail2Label setFont:[FontUtil fontWithFontSize:eFontSizeNormal Style:eFontStyleNormal]];

        if (indexPath.row == 2) {
            cell.header1Label.text = @"บริจาคเพื่อการศึกษา";
            cell.header2Label.text = @"บริจาคอื่นๆ";
            cell.detail1Label.text = @"3,000.00";
            cell.detail2Label.text = @"500.00";
        }
        else if (indexPath.row == 3) {
            cell.header1Label.text = @"เงินได้สุทธิ";
            cell.header2Label.text = @"ภาษีคำนวนจากเงินได้สุทธิ";
            cell.detail1Label.text = @"330,000.00";
            cell.detail2Label.text = @"2,000.00";
        }
        return cell;
    }
    return nil;
    
//    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (selectionCell.count == 0) {
        [selectionCell addObject:[NSString stringWithFormat:@"%d",indexPath.row]];
        
    }
    else
    {
        BOOL isAdding = YES;
        for (int cSelection = 0; cSelection < selectionCell.count; cSelection++) {
            if ([[JLString removeNullString:[selectionCell objectAtIndex:cSelection]]isEqualToString:[NSString stringWithFormat:@"%d",indexPath.row]]) {
                [selectionCell removeObject:[NSString stringWithFormat:@"%d",indexPath.row]];
                isAdding = NO;
            }
        }
        if (isAdding) {
            [selectionCell addObject:[NSString stringWithFormat:@"%d",indexPath.row]];
            //                selectIndex = indexPath.row;
        }
    }
    
    [tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];

}

@end

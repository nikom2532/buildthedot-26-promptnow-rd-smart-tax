//
//  PaymentGridViewCell.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/1/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import "PaymentGridViewCell.h"

@implementation PaymentGridViewCell
@synthesize BankImg;
- (id) initWithFrame: (CGRect) frame reuseIdentifier: (NSString *) aReuseIdentifier
{
    self = [super initWithFrame: frame reuseIdentifier: aReuseIdentifier];
    
    
    //app_reach_saller_10 135 18
    //    BGImg = [[UIImageView alloc]initWithFrame:CGRectMake(3,10, 94, 119)];
    //    [BGImg setContentMode:UIViewContentModeScaleAspectFit];
    //
    BankImg = [[UIImageView alloc]initWithFrame:CGRectMake(5,5, 50, 50)];
    [BankImg setContentMode:UIViewContentModeScaleAspectFit];
    //
    //    timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CoverImg.frame.origin.y+CoverImg.frame.size.height, 100, 18)];
    //    [timeLabel setBackgroundColor:[UIColor clearColor]];
    //    [timeLabel setTextColor:[UIColor whiteColor]];
    //    [timeLabel setFont:[UIFont systemFontOfSize:7]];
    //    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    //    [timeLabel setNumberOfLines:2];
    //
    //    DownloadImg = [[UIImageView alloc]initWithFrame:CGRectMake(25,timeLabel.frame.origin.y+timeLabel.frame.size.height, 52, 17)];
    //    [DownloadImg setContentMode:UIViewContentModeScaleToFill];
    //    [DownloadImg setImage:[UIImage imageNamed:@"bt_download.png"]];
    
    
    return self;
}
- (void) layoutSubviews
{
    [super layoutSubviews];
    //    [self addSubview: BGImg];
    [self addSubview:BankImg];
    //    [self addSubview: timeLabel];
    //    [self addSubview: DownloadImg];
    
}
@end

//
//  ENCheckTemptaxform.m
//  RDSmartTax
//
//  Created by saritwat anutakonpatipan on 1/4/2557 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import "ENCheckTemptaxform.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"
#import "ShareUserDetail.h"
@implementation ENCheckTemptaxform
{
    NSDictionary *receivedData;
}

- (void) requestENCheckTemptaxformService
{
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:[Util loadAppSettingWithName:@"Session"] forKey:@"sessionID"];
    NSString *lang;
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        lang = @"TH";
    } else {
        lang = @"EN";
    }
    [dictionary setValue:lang forKey:@"language"];
    [dictionary setValue:@"" forKey:@"latitude"];
    [dictionary setValue:@"" forKey:@"longitude"];
    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
    
    [dictionary setValue:[ShareUserDetail retrieveDataWithStringKey:@"nid"] forKey:@"nid"];
    [dictionary setValue:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"] forKey:@"authenKey"];
//    [dictionary setValue:@"" forKey:@"apiRefNo"];
//    
//    [dictionary setValue:@"" forKey:@"keys"];
    
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        
        [susanooObject sendSecuredRequestToService:@"fl-check-temptaxform.service" withJSONData:postData];
    }
    
}
-(void)susanooConnectionDidStart:(SusanooRequest *)request
{
    JLLog(@"start");
    
}
-(void)susanooConnectionDidMakeProgress:(SusanooRequest *)request
{
    JLLog(@"make Progress");
    
}
-(void)susanooConnectionDidFinish:(SusanooResponse *)response
{
    JLLog(@"finish");
    receivedData = response.responseData;
    [_delegate responseENCheckTemptaxformService:receivedData];
    [SVProgressHUD dismiss];
    
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    JLLog(@"fail");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:response.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@end

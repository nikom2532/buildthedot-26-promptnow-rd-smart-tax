//
//  ENCheckVersionService.m
//  RDSmartTax
//
//  Created by fone on 1/16/57 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import "ENCheckVersionService.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"

@implementation ENCheckVersionService {
    NSDictionary *receivedData;
}
- (void) requestENCheckVersionService : (NSString *) version {
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSString *lang;
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        lang = @"TH";
    } else {
        lang = @"EN";
    }
    [dictionary setValue:[OpenUDID value] forKey:@"sessionID"];
    [dictionary setValue:lang forKey:@"language"];
    [dictionary setValue:@"" forKey:@"latitude"];
    [dictionary setValue:@"" forKey:@"longitude"];
    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
    [dictionary setValue:version forKey:@"version"];
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        
        [susanooObject sendRequestToService:@"lg-update-version.service" withJSONData:postData];
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
    [_delegate responseENCheckVersionService:receivedData];
    [SVProgressHUD dismiss];
    
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    JLLog(@"fail");
    receivedData = response.responseData;
    [_delegate responseENCheckVersionService:receivedData];
    [SVProgressHUD dismiss];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    JLLog(@"time out");
    [SVProgressHUD dismiss];
}
@end

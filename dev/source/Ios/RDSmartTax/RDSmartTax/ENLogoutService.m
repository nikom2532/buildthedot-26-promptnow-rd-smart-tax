//
//  ENLogoutService.m
//  RDSmartTax
//
//  Created by fone on 1/13/57 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import "ENLogoutService.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"

@implementation ENLogoutService {
    NSDictionary *receivedData;
}
- (void) requestENLogoutServiceWithNid : (NSString *) nid {
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
    //-- create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    NSString *lang;
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        lang = @"TH";
    } else {
        lang = @"EN";
    }
    [dictionary setValue:[Util loadAppSettingWithName:@"Session"] forKey:@"sessionID"];
    [dictionary setValue:lang forKey:@"language"];
    [dictionary setValue:@"" forKey:@"latitude"];
    [dictionary setValue:@"" forKey:@"longitude"];
    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
    [dictionary setValue:nid forKey:@"nid"];
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        
        [susanooObject sendSecuredRequestToService:@"lg-logout.service" withJSONData:postData];
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
    [_delegate responseENLogoutService:receivedData];
    [SVProgressHUD dismiss];
    
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    JLLog(@"fail");
    receivedData = response.responseData;
    [_delegate responseENLogoutService:receivedData];
    [SVProgressHUD dismiss];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    JLLog(@"time out");
    [SVProgressHUD dismiss];
}
@end

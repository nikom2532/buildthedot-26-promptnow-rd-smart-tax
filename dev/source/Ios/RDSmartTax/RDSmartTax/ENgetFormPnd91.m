//
//  ENgetFormPnd91.m
//  TaxEasy
//
//  Created by Tax on 7/12/56.
//  Copyright (c) พ.ศ. 2556 Tax. All rights reserved.
//

#import "ENgetFormPnd91.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"

#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/pnd91/getFormPnd91.json"

@implementation ENgetFormPnd91
{
    NSDictionary *receivedData;
}

//- (void) requestENgetFormPnd91Service
//{
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];
//
//        [request setHTTPMethod:@"GET"];
//        [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
//        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//        if(!connection){
//            NSLog(@"Connection Failed");
//        }
//    //-- create data that will be sent in the post
//        NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
//        [dictionary setValue:[Util loadAppSettingWithName:@"Version"] forKey:@"version"];
//    
//    //-- serialize the dictionary data as json
//        NSData *data = [[dictionary copy] JSONValue];
//    
//    //    //-- set the data as the post body
//        [request setHTTPBody:data];
//        [request addValue:[NSString stringWithFormat:@"%d",data.length] forHTTPHeaderField:@"Content-Length"];
//    
//    
//    
//    //    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc]init];
//    //    [dictionary setValue:nid forKey:@"nid"];
//    //    [dictionary setValue:appDelegate.sessionIDapp forKey:@"sessionID"];
//    //    [dictionary setValue:lang forKey:@"language"];
//    //    [dictionary setValue:@"" forKey:@"latitude"];
//    //    [dictionary setValue:@"" forKey:@"longitude"];
//    //    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
//    //    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
//    //    susanooObject = [[Susanoo alloc] init];
//    //    [susanooObject setDelegate:self];
//    //    [susanooObject sendSecuredRequestToService:@"fl-get-formpnd91.service" withJSONData:nil];
//    
////    susanooObject = [[Susanoo alloc] init];
////    [susanooObject setDelegate:self];
////
////    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
////    
////
////    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
////    [dictionary setValue:[Util loadAppSettingWithName:@"Session"] forKey:@"sessionID"];
////    NSString *lang;
////    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
////        lang = @"TH";
////    } else {
////        lang = @"EN";
////    }
////    [dictionary setValue:lang forKey:@"language"];
////    [dictionary setValue:@"" forKey:@"latitude"];
////    [dictionary setValue:@"" forKey:@"longitude"];
////    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
////    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
////    
////    [dictionary setValue:[ShareUserDetail retrieveDataWithStringKey:@"nid"] forKey:@"nid"];
////    [dictionary setValue:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"] forKey:@"authenKey"];
////
////    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
////        NSError *error;
////        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
////        
////        [susanooObject sendSecuredRequestToService:@"fl-get-formpnd91.service" withJSONData:postData];
////    }
//    
//    
////    susanooObject = [[Susanoo alloc] init];
////    [susanooObject setDelegate:self];
////    
////    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
////    
////    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
////    [dictionary setValue:[Util loadAppSettingWithName:@"Session"] forKey:@"sessionID"];
////    NSString *lang;
////    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
////        lang = @"TH";
////    } else {
////        lang = @"EN";
////    }
////    [dictionary setValue:lang forKey:@"language"];
////    [dictionary setValue:@"" forKey:@"latitude"];
////    [dictionary setValue:@"" forKey:@"longitude"];
////    [dictionary setValue:[OpenUDID value] forKey:@"deviceID"];
////    [dictionary setValue:[Util loadAppSettingWithName:@"DeviceType"] forKey:@"deviceType"];
////    
////    [dictionary setValue:[ShareUserDetail retrieveDataWithStringKey:@"nid"] forKey:@"nid"];
////    [dictionary setValue:[ShareUserDetail retrieveDataWithStringKey:@"authenKey"] forKey:@"authenKey"];
////
////    
////    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
////        NSError *error;
////        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
////        
////        [susanooObject sendSecuredRequestToService:@"fl-get-formpnd91.service" withJSONData:postData];
////    }
//
//}
////-(void)susanooConnectionDidStart:(SusanooRequest *)request
////{
////    JLLog(@"start");
////    
////}
////-(void)susanooConnectionDidMakeProgress:(SusanooRequest *)request
////{
////    JLLog(@"make Progress");
////    
////}
////-(void)susanooConnectionDidFinish:(SusanooResponse *)response
////{
////    JLLog(@"finish");
////    receivedData = response.responseData;
////    [_delegate responseENgetFormPnd91Service:receivedData];
////    [SVProgressHUD dismiss];
////    
////}
////-(void)susanooConnectionDidFail:(SusanooResponse *)response
////{
////    JLLog(@"fail");
////    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:response.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
////    [alert show];
////}
////-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
////{
////    
////}
//#pragma mark - Data connection delegate -
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
//
//    receivedData = dic;
//}
//
//-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
//    NSLog(@"Connection failed with error: %@",error.localizedDescription);
//}
//
//-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
//}
//
//-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
//    [SVProgressHUD dismiss];
//    [self.delegate responseENgetFormPnd91Service:receivedData]; //send the data to the delegate
//}
- (void) requestENgetFormPnd91Service {
    if ([Util isInternetConnect]) {
        //-- check version
      
    } else {
        [Util alertUtilWithTitle:[Util stringWithScreenName:@"Commmon" labelName:@"Sorry"] msg:[Util loadErrorMessageWithValidateField:@"noInternetConnection"]];
        return;
    }
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    //    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostName,kServiceUrl]]];
    //
    //    [request setHTTPMethod:@"POST"];
    //    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
    
    //-- create data that will be sent in the post
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
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        
        [susanooObject sendSecuredRequestToService:@"fl-get-formpnd91.service" withJSONData:postData];
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
    [_delegate responseENgetFormPnd91Service:receivedData];
    [SVProgressHUD dismiss];
    
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    JLLog(@"fail");
    [SVProgressHUD dismiss];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:response.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    JLLog(@"time out");
    [SVProgressHUD dismiss];
}
@end

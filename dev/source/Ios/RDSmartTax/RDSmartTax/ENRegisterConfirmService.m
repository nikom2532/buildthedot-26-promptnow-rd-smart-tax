//
//  ENRegisterConfirmService.m
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ENRegisterConfirmService.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"

#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/register/confirm.json"
@implementation ENRegisterConfirmService {
    NSDictionary *receivedData;
}
- (void) requestENRegisterConfirmService : (NSString *) nid
                                buildName: (NSString *) buildName
                                   roomNo: (NSString *) roomNo
                                  floorNo: (NSString *) floorNo
                                addressNo: (NSString *) addressNo
                                      soi: (NSString *) soi
                                  village: (NSString *) village
                                    mooNo: (NSString *) mooNo
                                   street: (NSString *) street
                                   tambon: (NSString *) tambon
                                   amphur: (NSString *) amphur
                                 province: (NSString *) province
                                 postCode: (NSString *) postCode
                               contractNo: (NSString *) contractNo{
    
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];
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
    
    [dictionary setValue:nid forKey:@"nid"];
    [dictionary setValue:buildName forKey:@"buildName"];
    [dictionary setValue:roomNo forKey:@"roomNo"];
    [dictionary setValue:floorNo forKey:@"floorNo"];
    [dictionary setValue:addressNo forKey:@"addressNo"];
    [dictionary setValue:soi forKey:@"soi"];
    [dictionary setValue:village forKey:@"village"];
    [dictionary setValue:mooNo forKey:@"mooNo"];
    [dictionary setValue:street forKey:@"street"];
    [dictionary setValue:tambon forKey:@"tambon"];
    [dictionary setValue:amphur forKey:@"amphur"];
    [dictionary setValue:province forKey:@"province"];
    [dictionary setValue:postCode forKey:@"postCode"];
    [dictionary setValue:contractNo forKey:@"contractNo"];
    
        //-- serialize the dictionary data as json
//    NSData *data = [[dictionary copy] JSONValue];
//    
//    //-- set the data as the post body
//    [request setHTTPBody:data];
//    [request addValue:[NSString stringWithFormat:@"%d",data.length] forHTTPHeaderField:@"Content-Length"];
//    
//    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
//    if(!connection){
//        NSLog(@"Connection Failed");
//    }
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        
        [susanooObject sendSecuredRequestToService:@"rg-confirm-form.service" withJSONData:postData];
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
    [_delegate responseENRegisterConfirmService:receivedData];
    [SVProgressHUD dismiss];
    
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    JLLog(@"fail");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:response.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    JLLog(@"time out");
}
//#pragma mark - Data connection delegate -
//-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
//    receivedData = data;
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
//    [self.delegate responseENRegisterConfirmService:receivedData]; //send the data to the delegate
//}

@end

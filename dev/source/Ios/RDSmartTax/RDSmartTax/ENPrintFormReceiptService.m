//
//  ENPrintFormReceiptService.m
//  RDSmartTax
//
//  Created by fone on 12/15/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ENPrintFormReceiptService.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"
#import "ShareUserDetail.h"

//#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/pit/printFormReceipt.json"

@implementation ENPrintFormReceiptService {
    NSDictionary *receivedData;
}

- (void) requestENPrintFormReceiptServiceWithNid : (NSString *) nid
                                       authenKey : (NSString *) authenKey
                                        formCode : (NSString *) formCode
                                        formType : (NSString *) formType
                                         taxYear : (NSString *) taxYear {
    
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];
//    
//    [request setHTTPMethod:@"POST"];
//    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
//    
//    //-- create data that will be sent in the post
    
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:nid forKey:@"nid"];
    [dictionary setValue:authenKey forKey:@"authenKey"];
    [dictionary setValue:formCode forKey:@"formCode"];
    [dictionary setValue:formType forKey:@"formType"];
    [dictionary setValue:taxYear forKey:@"taxYear"];
    
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
    
    if ([NSJSONSerialization isValidJSONObject:dictionary]) {
        NSError *error;
        NSData *postData = [NSJSONSerialization dataWithJSONObject:dictionary options:0 error:&error];
        
        [susanooObject sendSecuredRequestToService:@"fl-print-formreceipt.service" withJSONData:postData];
    }
    
//    //-- serialize the dictionary data as json
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
//    [self.delegate responseENPrintFormReceiptService:receivedData]; //send the data to the delegate
//}

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
    [_delegate responseENPrintFormReceiptService:receivedData];
    [SVProgressHUD dismiss];
    
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    [SVProgressHUD dismiss];
    JLLog(@"fail");
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:response.description delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    //    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [SVProgressHUD dismiss];
    JLLog(@"time out");
}

@end

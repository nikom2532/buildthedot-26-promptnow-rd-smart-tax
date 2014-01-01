//
//  ENChangePassword.m
//  RDSmartTax
//
//  Created by Noi on 12/21/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ENChangePassword.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"
#import "ShareUserDetail.h"

#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/register/changePassword.json"
@implementation ENChangePassword{
    NSData *receivedData;
}


- (void) requestENChangePasswordService : (NSString *) userId
                            oldPassword : (NSString *) oldPassword
                            newPassword : (NSString *) newPassword
                                version : (NSString *) version{
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];
    
    [request setHTTPMethod:@"POST"];
    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
    
    //-- create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:userId forKey:@"userId"];
    [dictionary setValue:oldPassword forKey:@"oldPassword"];
    [dictionary setValue:newPassword forKey:@"newPassword"];
    [dictionary setValue:version forKey:@"version"];
    
    //-- serialize the dictionary data as json
    NSData *data = [[dictionary copy] JSONValue];
    
    //-- set the data as the post body
    [request setHTTPBody:data];
    [request addValue:[NSString stringWithFormat:@"%d",data.length] forHTTPHeaderField:@"Content-Length"];
    
    NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if(!connection){
        NSLog(@"Connection Failed");
    }
    
}

#pragma mark - Data connection delegate -
-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    receivedData = data;
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
    NSLog(@"Connection failed with error: %@",error.localizedDescription);
}

-(void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge{
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    [SVProgressHUD dismiss];
    [self.delegate responseENChangePasswordService:receivedData]; //send the data to the delegate
}


@end
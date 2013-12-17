//
//  ENRegisterSaveService.m
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ENRegisterSaveService.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "SVProgressHUD.h"

#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/register/save.json"
@implementation ENRegisterSaveService{
    NSData *receivedData;
}
- (void) requestENRegisterSaveService :(NSString *)nid
                              password:(NSString *)password
                                 email:(NSString *)email
                             birthDate:(NSString *)birthDate
                            questionId:(NSString *)questionId
                                answer:(NSString *)answer
                                  name:(NSString *)name
                               surname:(NSString *)surname
                             telephone:(NSString *)telephone
                    telephoneExtension:(NSString *)telephoneExtension
                            fatherName:(NSString *)fatherName
                            motherName:(NSString *)motherName
                            passportNo:(NSString *)passportNo
                           countryCode:(NSString *)countryCode
                               moiFlag:(NSString *)moiFlag
                               version:(NSString *)version;{
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];

    [request setHTTPMethod:@"POST"];
    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
    
    //-- create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:nid forKey:@"nid"];
    [dictionary setValue:name forKey:@"name"];
    [dictionary setValue:surname forKey:@"surname"];
    [dictionary setValue:birthDate forKey:@"birthDate"];
    [dictionary setValue:passportNo forKey:@"passportNo"];
    [dictionary setValue:countryCode forKey:@"countryCode"];
    [dictionary setValue:fatherName forKey:@"fatherName"];
    [dictionary setValue:motherName forKey:@"motherName"];
    [dictionary setValue:telephone forKey:@"telephone"];
    [dictionary setValue:telephoneExtension forKey:@"telephoneExtension"];
    [dictionary setValue:password forKey:@"password"];
    [dictionary setValue:questionId forKey:@"questionId"];
    [dictionary setValue:answer forKey:@"answer"];
    [dictionary setValue:email forKey:@"email"];
    [dictionary setValue:moiFlag forKey:@"moiFlag"];
    [dictionary setValue:[Util loadAppSettingWithName:@"Version"] forKey:@"version"];
    
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
    [self.delegate responseENRegisterSaveService:receivedData]; //send the data to the delegate
}

@end


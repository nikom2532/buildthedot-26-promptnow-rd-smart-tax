//
//  ENUpdateProfileService.m
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ENUpdateProfileService.h"
#import "ShareUserDetail.h"
#import "JSONDictionaryExtensions.h"
#import "Util.h"
#import "ShareUserDetail.h"
#import "SVProgressHUD.h"

//#define kServiceUrl @"http://kimhun55.com/llnun/TestServiceRD/mobile/register/updateProfile.json"

@implementation ENUpdateProfileService {
    NSDictionary *receivedData;
}

- (void) requestENUpdateProfileServiceWithNid : (NSString *) nid
                                    authenKey : (NSString *) authenKey
                                    nameTitle : (NSString *) nameTitle
                                         name : (NSString *) name
                                   middleName : (NSString *) middleName
                                      surname : (NSString *) surname
                                          tel : (NSString *) tel
                                        email : (NSString *) email
                                   passportId : (NSString *) passportId
                                      country : (NSString *) country
                                    buildName : (NSString *) buildName
                                       roomNo : (NSString *) roomNo
                                      floorNo : (NSString *) floorNo
                                    addressNo : (NSString *) addressNo
                                          soi : (NSString *) soi
                                      village : (NSString *) village
                                        mooNo : (NSString *) mooNo
                                       street : (NSString *) street
                                       tambol : (NSString *) tambol
                                       amphur : (NSString *) amphur
                                     province : (NSString *) province
                                     postCode : (NSString *) postCode
                               taxpayerStatus : (NSString *) taxpayerStatus
                                 spouseStatus : (NSString *) spouseStatus
                                  marryStatus : (NSString *) marryStatus
                                    spouseNid : (NSString *) spouseNid
                                   spouseName : (NSString *) spouseName
                                spouseSurname : (NSString *) spouseSurname
                              spouseBirthDate : (NSString *) spouseBirthDate
                             spousePassportId : (NSString *) spousePassportId
                                spouseCountry : (NSString *) spouseCountry
                                 childNoStudy : (NSString *) childNoStudy
                                   childStudy : (NSString *) childStudy
                                 txpFatherPin : (NSString *) txpFatherPin
                                 txpMotherPin : (NSString *) txpMotherPin
                              spouseFatherPin : (NSString *) spouseFatherPin
                              spouseMotherPin : (NSString *) spouseMotherPin {
    
    susanooObject = [[Susanoo alloc] init];
    [susanooObject setDelegate:self];
    
    [SVProgressHUD showWithStatus:[Util stringWithScreenName:@"Common" labelName:@"Loading"]];
    
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:kServiceUrl]];
//    
//    [request setHTTPMethod:@"POST"];
//    [request addValue:@"postValues" forHTTPHeaderField:@"METHOD"];
    
    //-- create data that will be sent in the post
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] init];
    [dictionary setValue:nid forKey:@"nid"];
    [dictionary setValue:authenKey forKey:@"authenKey"];
    [dictionary setValue:nameTitle forKey:@"titleName"];
    [dictionary setValue:name forKey:@"name"];
    [dictionary setValue:middleName forKey:@"middleName"];
    [dictionary setValue:surname forKey:@"surname"];
    [dictionary setValue:tel forKey:@"contractNo"];
    [dictionary setValue:email forKey:@"email"];///// new field
    [dictionary setValue:country forKey:@"countryCode"];///// new field
    [dictionary setValue:passportId forKey:@"passportNo"];///// new field
    
    [dictionary setValue:buildName forKey:@"buildName"];
    [dictionary setValue:roomNo forKey:@"roomNo"];
    [dictionary setValue:floorNo forKey:@"floorNo"];
    [dictionary setValue:addressNo forKey:@"addressNo"];
    [dictionary setValue:soi forKey:@"soi"];
    [dictionary setValue:village forKey:@"village"];
    [dictionary setValue:mooNo forKey:@"mooNo"];
    [dictionary setValue:street forKey:@"street"];
    [dictionary setValue:tambol forKey:@"tambol"];
    [dictionary setValue:amphur forKey:@"amphur"];
    [dictionary setValue:province forKey:@"province"];
    [dictionary setValue:postCode forKey:@"postcode"];
    
    [dictionary setValue:taxpayerStatus forKey:@"taxpayerStatus"];
    [dictionary setValue:spouseStatus forKey:@"spouseStatus"];
    [dictionary setValue:marryStatus forKey:@"marryStatus"];
    [dictionary setValue:spouseNid forKey:@"spouseNid"];
    [dictionary setValue:spouseName forKey:@"spouseName"];
    [dictionary setValue:spouseSurname forKey:@"spouseSurname"];
    [dictionary setValue:spouseBirthDate forKey:@"spouseBirthDate"];
    [dictionary setValue:spousePassportId forKey:@"spousePassportNo"];
    [dictionary setValue:spouseCountry forKey:@"spouseCountryCode"];
    [dictionary setValue:childNoStudy forKey:@"childNoStudy"];
    [dictionary setValue:childStudy forKey:@"childStudy"];
    [dictionary setValue:txpFatherPin forKey:@"txpFatherPin"];
    [dictionary setValue:txpMotherPin forKey:@"txpMotherPin"];
    [dictionary setValue:spouseFatherPin forKey:@"spouseFatherPin"];
    [dictionary setValue:spouseMotherPin forKey:@"spouseMotherPin"];
    
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
        
        [susanooObject sendSecuredRequestToService:@"pf-update-taxpayerprofile.service" withJSONData:postData];
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
//    [self.delegate responseENUpdateProfileService:receivedData]; //send the data to the delegate
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
    [_delegate responseENUpdateProfileService:receivedData];
    [SVProgressHUD dismiss];
    
}
-(void)susanooConnectionDidFail:(SusanooResponse *)response
{
    JLLog(@"fail");
    receivedData = response.responseData;
    [_delegate responseENUpdateProfileService:receivedData];
    [SVProgressHUD dismiss];
}
-(void)susanooConnectionDidTimeout:(SusanooResponse *)response
{
    JLLog(@"time out");
    [SVProgressHUD dismiss];
}

@end

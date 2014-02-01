//
//  ShareUserDetail.m
//  RDSmartTax
//
//  Created by fone on 12/4/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ShareUserDetail.h"

@implementation ShareUserDetail

+ (void) initialData : (NSDictionary *) dic {
    
    //-- remove all data from nsuserdefault
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    NSDictionary *responseData = [dic objectForKey:@"responseData"];
    
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    
    [userPref setObject:[dic objectForKey:@"loginFirst"] forKey:@"loginFirst"];
    [userPref setObject:@"" forKey:@"displayTermsAndCondition"];
    [userPref setObject:[dic objectForKey:@"termsConditionDetail"] forKey:@"termsConditionDetail"];
    [userPref setObject:[dic objectForKey:@"lastAccessed"] forKey:@"lastAccessed"];
    [userPref setObject:[dic objectForKey:@"displaySatisfication"] forKey:@"displaySatisfication"];
    [userPref setObject:[dic objectForKey:@"timestamp_current"] forKey:@"timestamp_current"];
    
    NSMutableArray *label = [[NSMutableArray alloc]init];
    NSMutableArray *value = [[NSMutableArray alloc]init];
    NSDictionary *satisfactionData = [responseData objectForKey:@"satisfactionData"];
    NSDictionary *choices = [satisfactionData objectForKey:@"choices"];
    NSEnumerator *enumerator = [choices objectEnumerator];
    id object;
    while (object = [enumerator nextObject]) {
        [label addObject:[object objectForKey:@"label"]];
        [value addObject:[object objectForKey:@"value"]];
    }
    [userPref setObject:label forKey:@"label"];
    [userPref setObject:value forKey:@"value"];
    
    [userPref setObject:[responseData objectForKey:@"thaiNation"] forKey:@"thaiNation"];
    [userPref setObject:[responseData objectForKey:@"nid"] forKey:@"nid"];
    [userPref setObject:[responseData objectForKey:@"addressNo"] forKey:@"addressNo"];
    [userPref setObject:[responseData objectForKey:@"amphur"] forKey:@"amphur"];
    [userPref setObject:[responseData objectForKey:@"authenKey"] forKey:@"authenKey"];
    [userPref setObject:[responseData objectForKey:@"birthDate"] forKey:@"birthDate"];
    [userPref setObject:[responseData objectForKey:@"buildName"] forKey:@"buildName"];
    [userPref setObject:[responseData objectForKey:@"childNoStudy"] forKey:@"childNoStudy"];
    [userPref setObject:[responseData objectForKey:@"childStudy"] forKey:@"childStudy"];
    [userPref setObject:[responseData objectForKey:@"contractNo"] forKey:@"contractNo"];
    [userPref setObject:[responseData objectForKey:@"countryCode"] forKey:@"countryCode"];
    [userPref setObject:[responseData objectForKey:@"email"] forKey:@"email"];
    [userPref setObject:[responseData objectForKey:@"floorNo"] forKey:@"floorNo"];
    [userPref setObject:[responseData objectForKey:@"indcForm"] forKey:@"indcForm"];

    NSDictionary *marryHashDic = [responseData objectForKey:@"marryHash"];
    [userPref setObject:[marryHashDic objectForKey:@"0"] forKey:@"marryHash0"];
    [userPref setObject:[marryHashDic objectForKey:@"1"] forKey:@"marryHash1"];
    [userPref setObject:[marryHashDic objectForKey:@"2"] forKey:@"marryHash2"];
    [userPref setObject:[marryHashDic objectForKey:@"3"] forKey:@"marryHash3"];
    
    
//    NSMutableArray *titleId = [[NSMutableArray alloc]init];
//    NSMutableArray *titleName = [[NSMutableArray alloc]init];
//    NSDictionary *titleNameHashDic = [responseData objectForKey:@"titleNameHash"];
//    NSEnumerator *enumerator2 = [titleNameHashDic objectEnumerator];
//    id object2;
//    while (object2 = [enumerator2 nextObject]) {
//        [titleId addObject:[object2 objectForKey:@"titleId"]];
//        [titleName addObject:[object2 objectForKey:@"titleNameHash"]];
//    }
//    [userPref setObject:@"" forKey:@"titleId"];
//    [userPref setObject:@"" forKey:@"titleNameHash"];
    
    
    [userPref setObject:[responseData objectForKey:@"marryStatus"] forKey:@"marryStatus"];
    [userPref setObject:[responseData objectForKey:@"mooNo"] forKey:@"mooNo"];
    [userPref setObject:[responseData objectForKey:@"name"] forKey:@"name"];
    [userPref setObject:@"" forKey:@"middleName"];
    [userPref setObject:[responseData objectForKey:@"passportNo"] forKey:@"passportNo"];
    [userPref setObject:[responseData objectForKey:@"postcode"] forKey:@"postcode"];
    [userPref setObject:[responseData objectForKey:@"province"] forKey:@"province"];
    [userPref setObject:[responseData objectForKey:@"roomNo"] forKey:@"roomNo"];
    [userPref setObject:[responseData objectForKey:@"soi"] forKey:@"soi"];
    [userPref setObject:[responseData objectForKey:@"spouseBirthDate"] forKey:@"spouseBirthDate"];
    [userPref setObject:[responseData objectForKey:@"spouseCountryCode"] forKey:@"spouseCountryCode"];
    [userPref setObject:[responseData objectForKey:@"spouseFatherPin"] forKey:@"spouseFatherPin"];
    
    NSDictionary *spouseHashDic = [responseData objectForKey:@"spouseHash"];
    [userPref setObject:[spouseHashDic objectForKey:@"0"] forKey:@"spouseHash0"];
    [userPref setObject:[spouseHashDic objectForKey:@"1"] forKey:@"spouseHash1"];
    
    [userPref setObject:[responseData objectForKey:@"spouseMotherPin"] forKey:@"spouseMotherPin"];
    [userPref setObject:[responseData objectForKey:@"spouseName"] forKey:@"spouseName"];
    [userPref setObject:[responseData objectForKey:@"spouseNid"] forKey:@"spouseNid"];
    [userPref setObject:[responseData objectForKey:@"spousePassportNo"] forKey:@"spousePassportNo"];
    [userPref setObject:[responseData objectForKey:@"spouseStatus"] forKey:@"spouseStatus"];
    [userPref setObject:[responseData objectForKey:@"spouseSurname"] forKey:@"spouseSurname"];
    [userPref setObject:[responseData objectForKey:@"street"] forKey:@"street"];
    [userPref setObject:[responseData objectForKey:@"surname"] forKey:@"surname"];
    [userPref setObject:[responseData objectForKey:@"tambol"] forKey:@"tambol"];
    
    NSDictionary *taxpayerHashDic = [responseData objectForKey:@"taxpayerHash"];
    [userPref setObject:[taxpayerHashDic objectForKey:@"0"] forKey:@"taxpayerHash0"];
    [userPref setObject:[taxpayerHashDic objectForKey:@"1"] forKey:@"taxpayerHash1"];
    [userPref setObject:[taxpayerHashDic objectForKey:@"2"] forKey:@"taxpayerHash2"];
    [userPref setObject:[taxpayerHashDic objectForKey:@"3"] forKey:@"taxpayerHash3"];
    
    [userPref setObject:[responseData objectForKey:@"taxpayerStatus"] forKey:@"taxpayerStatus"];
    [userPref setObject:[responseData objectForKey:@"titleName"] forKey:@"titleName"];
    [userPref setObject:[responseData objectForKey:@"txpFatherPin"] forKey:@"txpFatherPin"];
    [userPref setObject:[responseData objectForKey:@"txpMotherPin"] forKey:@"txpMotherPin"];
    [userPref setObject:[responseData objectForKey:@"village"] forKey:@"village"];

    [userPref synchronize];

}

+ (NSString *) retrieveDataWithStringKey : (NSString *) key {
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    if ([userPref stringForKey:key]) {
        return [userPref stringForKey:key];
    } else {
        return @"";
    }
}

+ (void) resetData {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

+ (void) saveShareUserDetailWithKey : (NSString *) key text:(NSString *)text {
    
    if (![[NSUserDefaults standardUserDefaults] objectForKey:key]){
        
        [[NSUserDefaults standardUserDefaults] setObject:text forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
    } else {
        NSLog(@"Error : %@", [NSUserDefaults standardUserDefaults]);
    }
}

@end

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
    
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    [userPref setObject:[dic objectForKey:@"addressNo"] forKey:@"addressNo"];
    [userPref setObject:[dic objectForKey:@"amphur"] forKey:@"amphur"];
    [userPref setObject:[dic objectForKey:@"authenKey"] forKey:@"authenKey"];
    [userPref setObject:[dic objectForKey:@"birthDate"] forKey:@"birthDate"];
    [userPref setObject:[dic objectForKey:@"buildName"] forKey:@"buildName"];
    [userPref setObject:[dic objectForKey:@"childNoStudy"] forKey:@"childNoStudy"];
    [userPref setObject:[dic objectForKey:@"childStudy"] forKey:@"childStudy"];
    [userPref setObject:[dic objectForKey:@"contractNo"] forKey:@"contractNo"];
    [userPref setObject:[dic objectForKey:@"countryCode"] forKey:@"countryCode"];
    [userPref setObject:[dic objectForKey:@"email"] forKey:@"email"];
    [userPref setObject:[dic objectForKey:@"floorNo"] forKey:@"floorNo"];
    [userPref setObject:[dic objectForKey:@"indcForm"] forKey:@"indcForm"];

    NSDictionary *marryHashDic = [dic objectForKey:@"marryHash"];
    [userPref setObject:[marryHashDic objectForKey:@"0"] forKey:@"marryHash0"];
    [userPref setObject:[marryHashDic objectForKey:@"1"] forKey:@"marryHash1"];
    [userPref setObject:[marryHashDic objectForKey:@"2"] forKey:@"marryHash2"];
    [userPref setObject:[marryHashDic objectForKey:@"3"] forKey:@"marryHash3"];
    
    [userPref setObject:[dic objectForKey:@"marryStatus"] forKey:@"marryStatus"];
    [userPref setObject:[dic objectForKey:@"mooNo"] forKey:@"mooNo"];
    [userPref setObject:[dic objectForKey:@"name"] forKey:@"name"];
    [userPref setObject:[dic objectForKey:@"nid"] forKey:@"nid"];
    [userPref setObject:[dic objectForKey:@"passportNo"] forKey:@"passportNo"];
    [userPref setObject:[dic objectForKey:@"postcode"] forKey:@"postcode"];
    [userPref setObject:[dic objectForKey:@"province"] forKey:@"province"];
    [userPref setObject:[dic objectForKey:@"roomNo"] forKey:@"roomNo"];
    [userPref setObject:[dic objectForKey:@"soi"] forKey:@"soi"];
    [userPref setObject:[dic objectForKey:@"spouseBirthDate"] forKey:@"spouseBirthDate"];
    [userPref setObject:[dic objectForKey:@"spouseCountryCode"] forKey:@"spouseCountryCode"];
    [userPref setObject:[dic objectForKey:@"spouseFatherPin"] forKey:@"spouseFatherPin"];
    
    NSDictionary *spouseHashDic = [dic objectForKey:@"spouseHash"];
    [userPref setObject:[spouseHashDic objectForKey:@"0"] forKey:@"spouseHash0"];
    [userPref setObject:[spouseHashDic objectForKey:@"1"] forKey:@"spouseHash1"];
    
    [userPref setObject:[dic objectForKey:@"spouseMotherPin"] forKey:@"spouseMotherPin"];
    [userPref setObject:[dic objectForKey:@"spouseName"] forKey:@"spouseName"];
    [userPref setObject:[dic objectForKey:@"spouseNid"] forKey:@"spouseNid"];
    [userPref setObject:[dic objectForKey:@"spousePassportNo"] forKey:@"spousePassportNo"];
    [userPref setObject:[dic objectForKey:@"spouseStatus"] forKey:@"spouseStatus"];
    [userPref setObject:[dic objectForKey:@"spouseSurname"] forKey:@"spouseSurname"];
    [userPref setObject:[dic objectForKey:@"street"] forKey:@"street"];
    [userPref setObject:[dic objectForKey:@"surname"] forKey:@"surname"];
    [userPref setObject:[dic objectForKey:@"tambol"] forKey:@"tambol"];
    
    NSDictionary *taxpayerHashDic = [dic objectForKey:@"taxpayerHash"];
    [userPref setObject:[taxpayerHashDic objectForKey:@"0"] forKey:@"taxpayerHash0"];
    [userPref setObject:[taxpayerHashDic objectForKey:@"1"] forKey:@"taxpayerHash1"];
    [userPref setObject:[taxpayerHashDic objectForKey:@"2"] forKey:@"taxpayerHash2"];
    [userPref setObject:[taxpayerHashDic objectForKey:@"3"] forKey:@"taxpayerHash3"];
    
    [userPref setObject:[dic objectForKey:@"taxpayerStatus"] forKey:@"taxpayerStatus"];
    [userPref setObject:[dic objectForKey:@"titleName"] forKey:@"titleName"];
    [userPref setObject:[dic objectForKey:@"txpFatherPin"] forKey:@"txpFatherPin"];
    [userPref setObject:[dic objectForKey:@"txpMotherPin"] forKey:@"txpMotherPin"];
    [userPref setObject:[dic objectForKey:@"village"] forKey:@"village"];

    [userPref setObject:[dic objectForKey:@"thaiNation"] forKey:@"thaiNation"];
    
    [userPref synchronize];

}

+ (NSString *) retrieveDataWithStringKey : (NSString *) key {
    NSUserDefaults *userPref = [NSUserDefaults standardUserDefaults];
    return [userPref stringForKey:key];
}

+ (void) resetData {
    NSUserDefaults * defs = [NSUserDefaults standardUserDefaults];
    NSDictionary * dict = [defs dictionaryRepresentation];
    for (id key in dict) {
        [defs removeObjectForKey:key];
    }
    [defs synchronize];
}

@end
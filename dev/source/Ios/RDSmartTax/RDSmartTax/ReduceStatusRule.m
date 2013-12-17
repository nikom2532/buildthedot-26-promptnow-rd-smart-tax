//
//  ReduceStatusRule.m
//  RDSmartTax
//
//  Created by fone on 12/9/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import "ReduceStatusRule.h"
#import "Util.h"

@implementation ReduceStatusRule {
    NSArray *reduceStatusArray;
}

#pragma - mark RULE
+ (NSArray *) rule1_thaiSingle {
    
    //-- 1. Thai single -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
                                @"",
                                nil];
}

+ (NSArray *) rule2_engSingle {
    
    //-- 2. Eng single -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

+ (NSArray *) rule3_thai_thaiSpouse_haveSalary {
    
    //-- 3. Thai, thai spouse and have salary -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseNid"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

+ (NSArray *) rule4_thai_thaiSpouse_noSalary {
    
    //-- 4. Thai, thai spouse and no salary -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseNid"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseMotherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseFatherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

+ (NSArray *) rule5_thai_engSpouse_haveSalary {
    
    //-- 5. Thai, eng spouse and have salary -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseNid"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

+ (NSArray *) rule6_thai_engSpouse_noSalary {
    
    //-- 6. Thai, eng spouse and no salary -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

+ (NSArray *) rule7_eng_thaiSpouse_haveSalary {
    
    //-- 7. Eng, thai spouse and have salary -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseNid"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

+ (NSArray *) rule8_eng_thaiSpouse_noSalary {
    
    //-- 8. Eng, thai spouse and no salary -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseNid"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseMotherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseFatherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

+ (NSArray *) rule9_eng_engSpouse_haveSalary {
    
    //-- 9. Eng, eng spouse and have salary -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseNid"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

+ (NSArray *) rule10_eng_engSpouse_noSalary {
    
    //-- 10. Eng, eng spouse and no salary -----------------------------------------------------
    return [[NSArray alloc]initWithObjects:
                                [Util stringWithScreenName:@"Common" labelName:@"TaxpayerStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"MarryStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseStatus"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseName"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseSurname"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseBirthDate"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpousePassportId"],
                                [Util stringWithScreenName:@"Common" labelName:@"SpouseCountry"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpFatherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"TxpMotherPin"],
                                [Util stringWithScreenName:@"Common" labelName:@"ChildNoStudy"],
            [Util stringWithScreenName:@"Common" labelName:@"ChildStudy"],
            @"",
                                nil];
    
}

@end

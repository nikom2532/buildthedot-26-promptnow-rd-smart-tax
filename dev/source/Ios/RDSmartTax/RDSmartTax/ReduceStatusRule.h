//
//  ReduceStatusRule.h
//  RDSmartTax
//
//  Created by fone on 12/9/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReduceStatusRule : NSObject

+ (NSArray *) rule1_thaiSingle;
+ (NSArray *) rule2_engSingle;
+ (NSArray *) rule3_thai_thaiSpouse_haveSalary;
+ (NSArray *) rule4_thai_thaiSpouse_noSalary;
+ (NSArray *) rule5_thai_engSpouse_haveSalary;
+ (NSArray *) rule6_thai_engSpouse_noSalary;
+ (NSArray *) rule7_eng_thaiSpouse_haveSalary;
+ (NSArray *) rule8_eng_thaiSpouse_noSalary;
+ (NSArray *) rule9_eng_engSpouse_haveSalary;
+ (NSArray *) rule10_eng_engSpouse_noSalary;

@end

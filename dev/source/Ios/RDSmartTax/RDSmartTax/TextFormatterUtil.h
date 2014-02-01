//
//  TextFormatterUtil.h
//  POCTax
//
//  Created by fone on 11/22/56 BE.
//  Copyright (c) 2556 BuildTheDot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFormatterUtil : NSObject

+(NSNumberFormatter*) numberFormatter;
+(NSMutableString*) genDotString:(NSString*) str;
+(NSString*) formatMobileNo:(NSString *)source;
+(NSString*) formatHomeNo:(NSString *)source;
+(NSString*) formatAmount:(NSString *)source;
+(NSString*) formatCardNoWithMask:(NSString*) source;
+(NSString*) formatCardNo:(NSString *)source;
+(NSString*) formatAccountNoWithMask:(NSString*) source;
+(NSString*) formatAccountNo:(NSString*) source;
+(NSString*) formatIdCard:(NSString*) source;
+(NSString*) formatEmailMask:(NSString*) source;
+(NSDateFormatter*)dateFormatter01;
+(NSMutableString*) removeMinusSignFromString:(NSString*) string;
+(void) removeMinusSignFromMutableString:(NSMutableString*) string;
+(NSString*) convertDateFormatString:(NSString*) string;
+(NSMutableString*) convertStringToMutableString:(NSString*) string;
+(NSString*) reformatNumber:(NSString*) numberStr;
+(NSMutableString*) removeCommaSignFromString:(NSString*) string;
+(void) removeCommaSignFromMutableString:(NSMutableString*) string;
+(void) removePlusSignFromMutableString:(NSMutableString*) string;

@end

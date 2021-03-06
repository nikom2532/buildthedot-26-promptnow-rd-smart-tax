//
//  TextFormatterUtil.m
//  POCTax
//
//  Created by fone on 11/22/56 BE.
//  Copyright (c) 2556 BuildTheDot. All rights reserved.
//

#import "TextFormatterUtil.h"

@implementation TextFormatterUtil
static NSNumberFormatter* numberFormatter;

+(NSNumberFormatter*) numberFormatter
{
    if( numberFormatter == nil){
        numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
        [numberFormatter setMaximumFractionDigits:2];
        [numberFormatter setMinimumFractionDigits:0];
        [numberFormatter setMinimumIntegerDigits:1];
        [numberFormatter setGroupingSeparator:@","];
        [numberFormatter setAllowsFloats:YES];
        [numberFormatter setMinimumIntegerDigits:1];
    }
    return numberFormatter;
}

+(NSMutableString*) genDotString:(NSString*) str
{
    NSMutableString* displayString = [NSMutableString stringWithString:@""];
    for(int i=0;i<[str length];i++){
        [displayString appendString:@"●"];
    }
    return displayString;
}

+(NSString*) formatMobileNo:(NSString *)source
{
    NSMutableString *newSource = [self convertStringToMutableString:source];
    @try {
        [self removeMinusSignFromMutableString:newSource];
        [self removePlusSignFromMutableString:newSource];
        
        if( [[newSource substringToIndex:2] isEqualToString:@"66"]){
            newSource = [NSMutableString stringWithFormat:@"0%@",[newSource substringFromIndex:2 ]];
        }
        
        if( [newSource length] >= 10){
            source =  [NSString stringWithFormat:@"%@-%@-%@",
                       [newSource substringWithRange:NSMakeRange(0, 3)],
                       [newSource substringWithRange:NSMakeRange(3, 3)],
                       [newSource substringWithRange:NSMakeRange(6, [newSource length]-6)]];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Handle Exception");
    }
    return source;
}

+(NSString*) formatHomeNo:(NSString *)source
{
    NSMutableString *newSource = [self convertStringToMutableString:source];
    @try {
        [self removeMinusSignFromMutableString:newSource];
        [self removePlusSignFromMutableString:newSource];
        
        if( [newSource length] >= 10){
            source =  [NSString stringWithFormat:@"%@-%@-%@",
                       [newSource substringWithRange:NSMakeRange(0, 2)],
                       [newSource substringWithRange:NSMakeRange(2, 4)],
                       [newSource substringWithRange:NSMakeRange(6, [newSource length]-6)]];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"Handle Exception");
    }
    return source;
}

+(NSString*) formatAmount:(NSString *)source
{
    source = [self removeCommaSignFromString:source];
    
    NSRange dotRange = [source rangeOfString:@"."];
    if(dotRange.length >= 1 && ( (dotRange.location +3) <= [source length])){
        source = [source substringToIndex:(dotRange.location + 3)];
    }
    
    if([source isEqualToString:@"."] || [source length] == 0){
        source = @"0";
    }
    
    [[TextFormatterUtil numberFormatter] setMinimumFractionDigits:2];
    source = [TextFormatterUtil reformatNumber:source];
    [[TextFormatterUtil numberFormatter] setMinimumFractionDigits:0];
    return source;
}

+(NSString*) formatCardNoWithMask:(NSString*) source
{
    NSString *newSource = [self removeMinusSignFromString:source];
    if ([newSource length] >= 16) {
        source = [NSString stringWithFormat:@"%@-%@xx-xxxx-%@",
                  [newSource substringWithRange:NSMakeRange(0, 4)],
                  [newSource substringWithRange:NSMakeRange(4, 2)],
                  [newSource substringWithRange:NSMakeRange(12, [newSource length]-12)]];
    }
    return source;
}

+(NSString*) formatCardNo:(NSString *)source
{
    NSString *newSource = [self removeMinusSignFromString:source];
    if ([newSource length] >= 16) {
        source = [NSString stringWithFormat:@"%@-%@-%@-%@",
                  [newSource substringWithRange:NSMakeRange(0, 4)],
                  [newSource substringWithRange:NSMakeRange(4, 4)],
                  [newSource substringWithRange:NSMakeRange(8, 4)],
                  [newSource substringWithRange:NSMakeRange(12, [newSource length]-12)]];
    }
    return source;
    
}

+(NSString*) formatAccountNoWithMask:(NSString*) source
{
    NSString *newSource = [self removeMinusSignFromString:source];
    if([newSource length] >= 10){
        
        int maskLength = [newSource length] - 9;
        NSMutableString *maskEnd = [[NSMutableString alloc] initWithString:@""];
        for(int i=0;i<maskLength;i++){
            [maskEnd appendString:@"x"];
        }
        
        source =  [NSString stringWithFormat:@"xxx-%@-%@-%@",
                   [newSource substringWithRange:NSMakeRange(3, 1)],
                   [newSource substringWithRange:NSMakeRange(4, 5)],
                   maskEnd];
    }
    return source;
    
}

+(NSString*) formatAccountNo:(NSString*) source
{
    NSString *newSource = [self removeMinusSignFromString:source];
    if([newSource length] >= 10){
        source =  [NSString stringWithFormat:@"%@-%@-%@-%@",
                   [newSource substringWithRange:NSMakeRange(0, 3)],
                   [newSource substringWithRange:NSMakeRange(3, 1)],
                   [newSource substringWithRange:NSMakeRange(4, 5)],
                   [newSource substringWithRange:NSMakeRange(9, [newSource length]-9)]];
    }
    return source;
}

+(NSString*) formatIdCard:(NSString*) source
{
    if([source length] == 13){
        source =  [NSString stringWithFormat:@"%@-%@-%@-%@-%@",
                   [source substringWithRange:NSMakeRange(0, 1)],
                   [source substringWithRange:NSMakeRange(1, 4)],
                   [source substringWithRange:NSMakeRange(5, 5)],
                   [source substringWithRange:NSMakeRange(10, 2)],
                   [source substringWithRange:NSMakeRange(12, [source length]-12)]];
    }
    return source;
}

+(NSString*) formatEmailMask:(NSString*) source {
    
    NSArray *allTextArray = [source componentsSeparatedByString:@"@"];
    NSString *username = [allTextArray objectAtIndex:0];
    NSArray *subTextArray = [[allTextArray objectAtIndex:1] componentsSeparatedByString:@"."];
    NSString *host;
    NSString *com1;
    NSString *com2;
   
    int subtextNo = subTextArray.count;
    if(subtextNo == 2){
        host = [subTextArray objectAtIndex:0];
        com1  = [subTextArray objectAtIndex:1];
    }else{
        host = [subTextArray objectAtIndex:0];
        com1  = [subTextArray objectAtIndex:1];
        com2  = [subTextArray objectAtIndex:2];
    }
    
    //-- username
    NSString *un1 = [username substringToIndex:2];
    NSString *un2 = [username substringWithRange:NSMakeRange(2, [username length]-4)];
    NSString *un3 = [username substringFromIndex:[username length]-2];
    
    NSMutableString* unMask = [NSMutableString string];
    for (int i=0; i<[un2 length]; i++){
        [unMask appendString:@"*"];
    }
    un2 = unMask;
    
    //-- host
    NSString *ho1 = [host substringToIndex:1];
    NSString *ho2 = [host substringFromIndex:1];
    
    NSMutableString* hoMask = [NSMutableString string];
    for (int i=0; i<[ho2 length]; i++){
        [hoMask appendString:@"*"];
    }
    ho2 = hoMask;
    
    //-- merge new string
    if(subtextNo == 2){
        return [NSString stringWithFormat:@"%@%@%@@%@%@.%@",un1,un2,un3,ho1,ho2,com1];
    }else{
        return [NSString stringWithFormat:@"%@%@%@@%@%@.%@.%@",un1,un2,un3,ho1,ho2,com1,com2];
    }
}

+(NSDateFormatter*)dateFormatter01
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc]init];
    [dateFormat setDateFormat: @"yyyyMMddHHmm"];
    return dateFormat;
}
+(NSString*) convertDateFormatString:(NSString*) string{
    
    NSArray* newDate = [string componentsSeparatedByString: @"/"];
    NSLog(@"beforeCut %@",newDate);
    NSString* date = [newDate objectAtIndex: 0];
    NSString* month = [newDate objectAtIndex: 1];
    NSString* year = [newDate objectAtIndex: 2];
    NSLog(@"selectYear %@",year);
    int selectYearInt = [year intValue];
    selectYearInt = selectYearInt - 543;
    NSString *selectYearStr = [NSString stringWithFormat:@"%d",selectYearInt];
    NSString *selectDateStr = [NSString stringWithFormat:@"%@%@%@%@%@",date,@"/",month,@"/",selectYearStr];
    NSLog(@"selectDateStr %@",selectDateStr);
    return selectDateStr;
    
}
+(NSMutableString*) removeMinusSignFromString:(NSString*) string
{
    NSMutableString *newString = [TextFormatterUtil convertStringToMutableString:string];
    [TextFormatterUtil removeMinusSignFromMutableString:newString];
    return newString;
}
+(void) removeMinusSignFromMutableString:(NSMutableString*) string
{
    [string replaceOccurrencesOfString:@"-" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
}
+(NSMutableString*) convertStringToMutableString:(NSString*) string
{
    return [NSMutableString stringWithString:string];
}

+(NSString*) reformatNumber:(NSString*) numberStr
{
    NSNumber *currentValue = [[TextFormatterUtil numberFormatter] numberFromString:numberStr];
    return [[TextFormatterUtil numberFormatter] stringFromNumber:currentValue];
}

+(NSMutableString*) removeCommaSignFromString:(NSString*) string
{
    NSMutableString *newString = [NSMutableString stringWithString:string];
    [TextFormatterUtil removeCommaSignFromMutableString:newString];
    return newString;
}

+(void) removeCommaSignFromMutableString:(NSMutableString*) string
{
    [string replaceOccurrencesOfString:@"," withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
}

+(void) removePlusSignFromMutableString:(NSMutableString*) string
{
    [string replaceOccurrencesOfString:@"+" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, [string length])];
}

@end

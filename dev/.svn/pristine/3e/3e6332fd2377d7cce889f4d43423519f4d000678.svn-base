//
//  JLString.m
//  MeeDaan
//
//  Created by Teeraphan on 10/4/12.
//  Copyright (c) 2012 Jorlek Company Limited. All rights reserved.
//

#import "JLString.h"

@implementation JLString

+(NSString *)removeNullString:(NSString *)string
{
    NSString *ans = [NSString stringWithFormat:@"%@",string];
    
    if([ans isEqualToString:@"(null)"] || [ans isEqualToString:@"null"] || [ans isEqualToString:@"<null>"])
    {
        ans = @"";
    }    
    
    return ans;
}

+(NSString*)changeNullString:(NSString*)string WithString:(NSString*)changeString
{
    NSString *ans = [NSString stringWithFormat:@"%@",string];
    
    if([ans isEqualToString:@"(null)"] || [ans isEqualToString:@"null"] || [ans isEqualToString:@"<null>"])
    {
        ans = changeString;
    }
    
    return ans;
}

+(CGFloat)calculateTextHeightWithString:(NSString*)string Width:(float)width Font:(UIFont*)font lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize constraint = CGSizeMake(width, 20000.0f);
//    CGSize size = [string sizeWithFont:font constrainedToSize:constraint lineBreakMode:lineBreakMode];
    CGSize size = [string sizeWithFont:font constrainedToSize:constraint lineBreakMode:lineBreakMode];
    CGFloat height = size.height;
    
    return height;
}

+(NSString *)fullPathWithFileName:(NSString *)filename
{
    return [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:filename];
}
+(BOOL)isEmailValid:(NSString *)string
{
    JLLog(@"String = %@",string);
    NSString *expression = @"^[_a-z0-9-]+(\\.[_a-z0-9-]+)*@[a-z0-9-]+(\\.[a-z0-9-]+)*(\\.[a-z]{2,3})$";
    JLLog(@"Expression = %@",expression);
    NSError *error = NULL;
    
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:expression options:NSRegularExpressionCaseInsensitive error:&error];
    
    NSTextCheckingResult *match = [regex firstMatchInString:string options:0 range:NSMakeRange(0, [string length])];
    
    if (match){
        JLLog(@"MATCH");
        return YES;
    }else{
        JLLog(@"NOT MATCH");
        return NO;
    }
}
+(NSString*)stringOf2Decimal:(NSString*)string
{
    if(!string)
    {
        return @"-";
    }
    
    NSNumber *result = [NSNumber numberWithDouble:[string doubleValue]];
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setDecimalSeparator:@"."];
    [numberFormatter setPositiveFormat:@"#,###,##0.00"];
    
    NSString *resultText = [numberFormatter stringFromNumber:result];
    
    return resultText;
}

@end

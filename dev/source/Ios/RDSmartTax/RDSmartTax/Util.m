//
//  Util.m
//  POCTax
//
//  Created by fone on 11/22/56 BE.
//  Copyright (c) 2556 BuildTheDot. All rights reserved.
//

#import "Util.h"
#import "TextFormatterUtil.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "JSONDictionaryExtensions.h"
#import "Reachability.h"

@implementation Util

+ (id) loadViewWithNibName:(NSString *)nibName
{
    NSArray *bundle = [[NSBundle mainBundle] loadNibNamed:nibName
                                                    owner:self
                                                  options:nil];
    
    id result = nil;
    for (id object in bundle)
    {
        if ([object isKindOfClass:NSClassFromString(nibName)])
            result = object;
    }
    return result;
}

+ (NSString *) loadAppSettingWithName : (NSString *) name {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"AppSetting.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"AppSetting" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    NSString *val = [data valueForKey:name];
    
    return val;
}

+ (void) saveAppSettingWithKey : (NSString *) key text:(NSString *)text {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"AppSetting.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"AppSetting" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] initWithContentsOfFile: path];
    
    [data setObject:text forKey:key];
    [data writeToFile: path atomically:YES];
}

#pragma mark - ALERT
+ (void) alertUtilWithTitle : (NSString *) title msg : (NSString *) msg {
    UIAlertView *tryMeAlertview = [[UIAlertView alloc] initWithTitle: title
                                                             message: msg
                                                            delegate: self
                                                   cancelButtonTitle: [Util stringWithScreenName:@"Common" labelName:@"Ok"]
                                                   otherButtonTitles: nil];
    
    [tryMeAlertview show];
}

#pragma mark - Language
+ (NSString *) stringWithScreenName:(NSString *) screenName labelName : (NSString *) labelName {
    
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"Languages.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"Languages" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Languages.plist" ofType:nil];
    NSMutableDictionary *langDict      = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    NSDictionary *screenNameDic = [langDict objectForKey:screenName];
    NSDictionary *labelDec = [screenNameDic objectForKey:labelName];
    
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        return [labelDec objectForKey:@"T"];
    } else {
        return [labelDec objectForKey:@"E"];
    }
    
}

#pragma mark - access config
+ (NSString *) retrieveValidateConfigFromKey:(NSString *) key {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ValidateConfig.plist"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"ValidateConfig" ofType:@"plist"];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ValidateConfig.plist" ofType:nil];
    NSMutableDictionary *langDict      = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return [langDict objectForKey:key];
}
//+ (NSString *) retrieveValidateMessageWithScreenName:(NSString *) screenName labelName : (NSString *) labelName {
//    
//    NSError *error;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"ValidateMessage.plist"];
//    
//    NSFileManager *fileManager = [NSFileManager defaultManager];
//    
//    if (![fileManager fileExistsAtPath: path])
//    {
//        NSString *bundle = [[NSBundle mainBundle] pathForResource:@"ValidateMessage" ofType:@"plist"];
//        
//        [fileManager copyItemAtPath:bundle toPath: path error:&error];
//    }
//    
//    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ValidateMessage.plist" ofType:nil];
//    NSMutableDictionary *langDict      = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
//    NSDictionary *screenNameDic = [langDict objectForKey:screenName];
//    NSDictionary *labelDec = [screenNameDic objectForKey:labelName];
//    
//    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
//        return [labelDec objectForKey:@"T"];
//    } else {
//        return [labelDec objectForKey:@"E"];
//    }
//    
//}

+ (BOOL) validateEmptyFieldWithString : (NSString *) text {
    if ([text isEqualToString:@""] || [text isEqualToString:@"(null)"] || text==nil) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) validateContractNumberWithString : (NSString *) text {
    if ([text length] < [[Util retrieveValidateConfigFromKey:@"rd.length.contractNo"] intValue]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) validateIDCardWithString : (NSString *) text {
    if ([text length] < [[Util retrieveValidateConfigFromKey:@"rd.length.idcard"] intValue]) {
        return YES;
    } else {
        return NO;
    }
}

+ (BOOL) validatePasswordIsEqualConfirmPassword : (NSString *) password confirmPassword : (NSString *) confirmPassword{
    if(![password isEqualToString:confirmPassword]){
        NSLog(@"Password field not match ");
        return YES;
    }else{
        return NO;
    }
    
}
+ (BOOL) validatePasswordIsCorrectFormat : (NSString *) password confirmPassword : (NSString *) confirmPassword{
    NSCharacterSet *passwordSet;
    passwordSet = [NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"];
    passwordSet = [passwordSet invertedSet];
    NSRange passwordRange = [password rangeOfCharacterFromSet:passwordSet];
    NSRange confirmPasswordRange = [confirmPassword rangeOfCharacterFromSet:passwordSet];
    if(passwordRange.location != NSNotFound && confirmPasswordRange.location != NSNotFound){
        return YES;
        
    }else{
        return NO;
    }
}
+ (BOOL) validatePasswordIsEmpty : (NSString *) password confirmPassword : (NSString *) confirmPassword{
    if([password length] < 8 && [confirmPassword length] < 8 ){
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL) validatePasswordEmpty : (NSString *) password{
    if([password length] < 8){
        return YES;
    }else{
        return NO;
    }
}
+ (BOOL) validatePasswordIsExceptWord : (NSString *) password{
    if([password caseInsensitiveCompare:@"password"] == NSOrderedSame){
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL) validateIsDuplicated13digits : (NSString *) str {
    int count = 0;
    NSString *targetString = [str substringWithRange:NSMakeRange(0, 1)];
    NSMutableArray *results = [[NSMutableArray alloc]init];

    for (int i=0; i<[str length]; i++) {
        [results addObject:[str substringWithRange:NSMakeRange(i, 1)]];
    }
    for (NSString *strObj in results) {
        if ([strObj rangeOfString:targetString].location != NSNotFound) {
            count = count+1;
        }
    }
    if (count == 13) {
        return YES;
    } else {
        return NO;
    }
}

+ (void) savePDFToDocumentOriginalFileNameWithURL : (NSString *) urlStr {
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlStr]];
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle]  resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
    NSString *filePath = [resourceDocPath stringByAppendingPathComponent:[Util retrievePdfFileNameWithURL:urlStr]];
    [pdfData writeToFile:filePath atomically:YES];
}

+ (BOOL)savePDFToDocumentWithURL : (NSString *) urlStr fileName : (NSString *) fileName {
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",fileName,@".pdf"]];
    NSString *path = [NSString stringWithFormat:@"%@%@%@%@%@%@",documentsDirectory,@"/",@"RDSmartTax",@"/",fileName,@".pdf"];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];

    if (![fileManager fileExistsAtPath: path]) {
        //-- create folder
        [fileManager createDirectoryAtPath:path withIntermediateDirectories:NO attributes:nil error:&error];

        //-- download file
        NSURL *url = [NSURL URLWithString:urlStr];
        NSData *data = [NSData dataWithContentsOfURL:url];
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [paths objectAtIndex:0];
//        NSString *pdfPath = [documentsDir stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@",fileName,@".pdf"]];
        NSString *pdfPath = [NSString stringWithFormat:@"%@%@%@%@%@%@",documentsDir,@"/",@"RDSmartTax",@"/",fileName,@".pdf"];
        [data writeToFile:pdfPath atomically:YES];
        return YES;
    } else {
        return NO;
    }
}

+(NSString*) retrievePdfFileNameWithURL:(NSString*) url {
    
    NSString *pdfName = @"";
    NSArray *separateTextToArray = [url componentsSeparatedByString:@"/"];
    for (int i=0; i<[separateTextToArray count]; i++) {
        if (i==[separateTextToArray count]-1) {
            pdfName = [separateTextToArray objectAtIndex:i];
        }
    }
    return pdfName;
}

+ (NSDateFormatter *) getDateFormatter {
    NSLocale *currentLocale;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = NSDateFormatterLongStyle;
    [dateFormatter setDateFormat:@"dd/MM/yyyy"];
    [dateFormatter setLocale:currentLocale];
    return dateFormatter;
}
+ (BOOL)validateEmail:(NSString *)emailStr {
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailStr];
}

+ (NSString *) convertBEToAD : (NSString*) year {
    return [NSString stringWithFormat:@"%d", [year intValue]-543];
}

+ (NSString *) convertToTis620WithData : (NSData*) data {
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingISOLatinThai);
    return [[NSString alloc]initWithData:data encoding:enc];
}
+ (void) saveImageToAlbumWithImage:(UIImage*)image
{
//    @property (strong, atomic) ALAssetsLibrary* library;

    ALAssetsLibrary * library = [[ALAssetsLibrary alloc] init];
    
    [library saveImage:image toAlbum:@"RDSmartTax" withCompletionBlock:^(NSError *error) {
        if (error!=nil) {
            NSLog(@"Big error: %@", [error description]);
        }
    }];
}
+ (NSString *) convertYearToBackSlashWithStringDate : (NSString *) dateString {
    if ([dateString length]==8) {
        NSString *date = [dateString substringToIndex:2];
        NSString *month = [dateString substringWithRange:NSMakeRange(2, 2)];
        NSString *year = [dateString substringFromIndex:[dateString length]-4];
        return [NSString stringWithFormat:@"%@%@%@%@%@",date,@"/",month,@"/",year];
    } else {
        return @"";
    }
    
}
+ (NSString *) loadErrorMessageWithValidateField : (NSString *) validateField {
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"message_error" ofType:@"json"];
    
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    NSDictionary *messageErrorDic = [dic objectForKey:@"message_error"];
    
    
    
    NSEnumerator *enumerator = [messageErrorDic objectEnumerator];
    
    id object;
    
    NSString *errorMessage;
    
    while (object = [enumerator nextObject]) {
        
        if ([[object objectForKey:@"validate_field"] isEqualToString:validateField]) {
            
            if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
                
                errorMessage = [object objectForKey:@"message_th"];
                
            } else {
                
                errorMessage = [object objectForKey:@"message_en"];
                
            }
            
        }
        
    }
    
    return errorMessage;
    
}
+ (NSString *) loadPlaceholder : (NSString *) fieldName{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"placeholder" ofType:@"json"];
    
    NSError *error = nil;
    
    NSData *data = [NSData dataWithContentsOfFile:filePath options:NSDataReadingMappedIfSafe error:&error];
    
    NSDictionary *dic = [NSDictionary dictionaryWithJSONData:data];
    
    NSDictionary *messageErrorDic = [dic objectForKey:@"placeholder"];
    
    
 
    NSEnumerator *enumerator = [messageErrorDic objectEnumerator];
    
    id object;
    
    NSString *errorMessage;
    
    while (object = [enumerator nextObject]) {
        
        if ([[object objectForKey:@"placeholder_name"] isEqualToString:fieldName]) {
            
            if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
                
                errorMessage = [object objectForKey:@"placeholder_th"];
                
            } else {
                
                errorMessage = [object objectForKey:@"placeholder_en"];
                
            }
            
        }
        
    }
    
    return errorMessage;

}

+ (BOOL) isInternetConnect {
    return [[Reachability reachabilityWithHostname:@"google.com"] currentReachabilityStatus] != NotReachable;
}

+ (BOOL)getConnectivityViaWiFiNetwork {
    return [[Reachability reachabilityWithHostname:@"google.com"] currentReachabilityStatus] == ReachableViaWiFi;
}

+ (BOOL)getConnectivityViaCarrierDataNetwork {
    return [[Reachability reachabilityWithHostname:@"google.com"] currentReachabilityStatus] == ReachableViaWWAN;
}

@end

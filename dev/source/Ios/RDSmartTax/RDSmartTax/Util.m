//
//  Util.m
//  POCTax
//
//  Created by fone on 11/22/56 BE.
//  Copyright (c) 2556 BuildTheDot. All rights reserved.
//

#import "Util.h"

@implementation Util
+ (id)loadViewWithNibName:(NSString *)nibName
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
    
    NSString *plistAppSettingPath = [[NSBundle mainBundle] pathForResource:@"AppSetting.plist" ofType:nil];
    NSMutableDictionary *langAppSettingDict = [NSMutableDictionary dictionaryWithContentsOfFile:plistAppSettingPath];
    
    return [langAppSettingDict valueForKey:name];
}

#pragma mark - ALERT
+ (void) alertUtilWithTitle : (NSString *) title msg : (NSString *) msg {
    UIAlertView *tryMeAlertview = [[UIAlertView alloc] initWithTitle: title
                                                             message: msg
                                                            delegate: self
                                                   cancelButtonTitle: @"Ok"
                                                   otherButtonTitles: nil];
    
    [tryMeAlertview show];
}

#pragma mark - Language
+ (NSString *) stringWithScreenName:(NSString *) screenName labelName : (NSString *) labelName {
    
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
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ValidateConfig.plist" ofType:nil];
    NSMutableDictionary *langDict      = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    return [langDict objectForKey:key];
}
+ (NSString *) retrieveValidateMessageWithScreenName:(NSString *) screenName labelName : (NSString *) labelName {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"ValidateMessage.plist" ofType:nil];
    NSMutableDictionary *langDict      = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    NSDictionary *screenNameDic = [langDict objectForKey:screenName];
    NSDictionary *labelDec = [screenNameDic objectForKey:labelName];
    
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        return [labelDec objectForKey:@"T"];
    } else {
        return [labelDec objectForKey:@"E"];
    }
    
}

+ (BOOL) validateEmptyFieldWithString : (NSString *) text {
    if ([text isEqualToString:@""] || [text isEqualToString:@"(null)"]) {
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
+ (BOOL) validatePasswordIsExceptWord : (NSString *) password confirmPassword : (NSString *) confirmPassword{
    if([password caseInsensitiveCompare:@"password"] == NSOrderedSame && [confirmPassword caseInsensitiveCompare:@"password"] == NSOrderedSame){
        return YES;
    }else{
        return NO;
    }
}


@end
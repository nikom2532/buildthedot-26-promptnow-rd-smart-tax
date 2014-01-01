//
//  Util.h
//  POCTax
//
//  Created by fone on 11/22/56 BE.
//  Copyright (c) 2556 BuildTheDot. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject {
}

+ (id) loadViewWithNibName:(NSString *)nibName;
+ (void) alertUtilWithTitle : (NSString *) title msg : (NSString *) msg ;
+ (NSString *) loadAppSettingWithName : (NSString *) name;
+ (void) saveAppSettingWithKey : (NSString *) key text:(NSString *)text;
+ (NSString *) stringWithScreenName:(NSString *) screenName labelName : (NSString *) labelName;
+ (NSString *) retrieveValidateConfigFromKey:(NSString *) key;
+ (NSString *) retrieveValidateMessageWithScreenName:(NSString *) screenName labelName : (NSString *) labelName;
+ (BOOL) validateEmptyFieldWithString : (NSString *) text;
+ (BOOL) validatePasswordIsEqualConfirmPassword : (NSString *) password confirmPassword : (NSString *) confirmPassword;
+ (BOOL) validatePasswordIsCorrectFormat : (NSString *) password confirmPassword : (NSString *) confirmPassword;
+ (BOOL) validatePasswordIsEmpty : (NSString *) password confirmPassword : (NSString *) confirmPassword;
+ (BOOL) validatePasswordIsExceptWord : (NSString *) password confirmPassword : (NSString *) confirmPassword;
+ (BOOL) validateIsDuplicated13digits : (NSString *) str;
+ (void) savePDFToDocumentOriginalFileNameWithURL : (NSString *) urlStr;
+ (NSString*) retrievePdfFileNameWithURL:(NSString*) url;
+ (NSDateFormatter *) getDateFormatter;
+ (BOOL)validateEmail:(NSString *)emailStr;
+ (BOOL)savePDFToDocumentWithURL : (NSString *) urlStr fileName : (NSString *) fileName;
@end

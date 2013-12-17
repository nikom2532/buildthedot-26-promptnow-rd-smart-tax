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

+ (id)loadViewWithNibName:(NSString *)nibName;
+ (void) alertUtilWithTitle : (NSString *) title msg : (NSString *) msg ;
+ (NSString *) loadAppSettingWithName : (NSString *) name;
+ (NSString *) stringWithScreenName:(NSString *) screenName labelName : (NSString *) labelName;
+ (NSString *) retrieveValidateConfigFromKey:(NSString *) key;
+ (NSString *) retrieveValidateMessageWithScreenName:(NSString *) screenName labelName : (NSString *) labelName;
+ (BOOL) validateEmptyFieldWithString : (NSString *) text;
+ (BOOL) validatePasswordIsEqualConfirmPassword : (NSString *) password confirmPassword : (NSString *) confirmPassword;
+ (BOOL) validatePasswordIsCorrectFormat : (NSString *) password confirmPassword : (NSString *) confirmPassword;
+ (BOOL) validatePasswordIsEmpty : (NSString *) password confirmPassword : (NSString *) confirmPassword;
+ (BOOL) validatePasswordIsExceptWord : (NSString *) password confirmPassword : (NSString *) confirmPassword;
@end
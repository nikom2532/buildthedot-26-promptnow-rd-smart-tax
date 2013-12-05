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

+ (NSString *) stringWithLabelName : (NSString *)labelName {
    
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"Languages.plist" ofType:nil];
    NSMutableDictionary *langDict      = [NSMutableDictionary dictionaryWithContentsOfFile:plistPath];
    NSDictionary* dict = [langDict objectForKey:labelName];
    
    if ([[Util loadAppSettingWithName:@"AppLanguage"] isEqualToString:@"T"]) {
        return [dict objectForKey:@"T"];
    } else {
        return [dict objectForKey:@"E"];
    }
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

@end

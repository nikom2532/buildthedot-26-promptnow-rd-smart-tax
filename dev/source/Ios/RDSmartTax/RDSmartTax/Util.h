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
+ (NSString *) stringWithLabelName : (NSString *)labelName;
+ (void) alertUtilWithTitle : (NSString *) title msg : (NSString *) msg ;
+ (NSString *) loadAppSettingWithName : (NSString *) name;

@end

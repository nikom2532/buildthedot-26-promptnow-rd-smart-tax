//
//  ENRegisterConfirmService.h
//  RDSmartTax
//
//  Created by Noi on 12/7/2556 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ENRegisterConfirmServiceDelegate <NSObject>

-(void)responseENRegisterConfirmService:(NSData*)data;

@end

@interface ENRegisterConfirmService : NSObject<NSURLConnectionDelegate,NSURLConnectionDataDelegate>
@property (strong,nonatomic) id <ENRegisterConfirmServiceDelegate> delegate;

- (void) requestENRegisterConfirmService : (NSString *) nid
                                buildName: (NSString *) buildName
                                   roomNo: (NSString *) roomNo
                                  floorNo: (NSString *) floorNo
                                addressNo: (NSString *) addressNo
                                      soi: (NSString *) soi
                                  village: (NSString *) village
                                    mooNo: (NSString *) mooNo
                                   street: (NSString *) street
                                   tambon: (NSString *) tambon
                                   amphur: (NSString *) amphur
                                 province: (NSString *) province
                                 postCode: (NSString *) postCode
                               contractNo: (NSString *) contractNo;



@end
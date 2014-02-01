//
//  ENUpdateProfileService.h
//  RDSmartTax
//
//  Created by fone on 12/7/56 BE.
//  Copyright (c) 2556 RevenueDepartment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Susanoo.h"
@protocol ENUpdateProfileServiceDelegate <NSObject>

-(void)responseENUpdateProfileService:(NSDictionary*)data;

@end

@interface ENUpdateProfileService : NSObject <NSURLConnectionDelegate,NSURLConnectionDataDelegate,SusanooDelegate>
{
    Susanoo *susanooObject;
}

@property (strong,nonatomic) id <ENUpdateProfileServiceDelegate> delegate;

- (void) requestENUpdateProfileServiceWithNid : (NSString *) nid
                                    authenKey : (NSString *) authenKey
                                    nameTitle : (NSString *) nameTitle
                                         name : (NSString *) name
                                   middleName : (NSString *) middleName
                                      surname : (NSString *) surname
                                          tel : (NSString *) tel
                                        email : (NSString *) email
                                   passportId : (NSString *) passportId
                                      country : (NSString *) country
                                    buildName : (NSString *) buildName
                                       roomNo : (NSString *) roomNo
                                      floorNo : (NSString *) floorNo
                                    addressNo : (NSString *) addressNo
                                          soi : (NSString *) soi
                                      village : (NSString *) village
                                        mooNo : (NSString *) mooNo
                                       street : (NSString *) street
                                       tambol : (NSString *) tambol
                                       amphur : (NSString *) amphur
                                     province : (NSString *) province
                                     postCode : (NSString *) postCode
                               taxpayerStatus : (NSString *) taxpayerStatus
                                 spouseStatus : (NSString *) spouseStatus
                                  marryStatus : (NSString *) marryStatus
                                    spouseNid : (NSString *) spouseNid
                                   spouseName : (NSString *) spouseName
                                spouseSurname : (NSString *) spouseSurname
                              spouseBirthDate : (NSString *) spouseBirthDate
                             spousePassportId : (NSString *) spousePassportId
                                spouseCountry : (NSString *) spouseCountry
                                 childNoStudy : (NSString *) childNoStudy
                                   childStudy : (NSString *) childStudy
                                 txpFatherPin : (NSString *) txpFatherPin
                                 txpMotherPin : (NSString *) txpMotherPin
                              spouseFatherPin : (NSString *) spouseFatherPin
                              spouseMotherPin : (NSString *) spouseMotherPin;


@end

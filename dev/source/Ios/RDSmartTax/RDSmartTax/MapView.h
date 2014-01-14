//
//  MapView.h
//  RDSmartTax
//
//  Created by fone on 1/14/57 BE.
//  Copyright (c) 2557 RevenueDepartment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface MapView : UIView
@property (weak, nonatomic) IBOutlet MKMapView *pMap;
@property (weak, nonatomic) IBOutlet UIButton *btnCurrentPosition;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;


@end

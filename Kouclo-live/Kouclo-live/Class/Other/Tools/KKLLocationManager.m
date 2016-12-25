//
//  KKLLocationManager.m
//  Kouclo-live
//
//  Created by liwei on 16/12/25.
//  Copyright © 2016年 live. All rights reserved.
//

#import "KKLLocationManager.h"
#import <CoreLocation/CoreLocation.h>

@interface KKLLocationManager()<CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager * locManager;

@property (nonatomic, copy) LocationBlock block;

@end

@implementation KKLLocationManager
+ (instancetype)sharedManager {
    
    static KKLLocationManager * _manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[KKLLocationManager alloc] init];
    });
    
    return _manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        _locManager = [[CLLocationManager alloc] init];
        [_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
        _locManager.distanceFilter = 100;
        _locManager.delegate = self;
        
        if (![CLLocationManager locationServicesEnabled]) {
            NSLog(@"开启定位服务");
        } else {
            
            CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
            if (status == kCLAuthorizationStatusNotDetermined) {
                [_locManager requestWhenInUseAuthorization];
            }
            
        }
    }
    return self;
}

- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
    
    CLLocationCoordinate2D coor = newLocation.coordinate;
    
    NSString * lat = [NSString stringWithFormat:@"%@",@(coor.latitude)];
    NSString * lon = [NSString stringWithFormat:@"%@",@(coor.longitude)];
    
    [KKLLocationManager sharedManager].lat = lat;
    [KKLLocationManager sharedManager].lon = lon;
    
    self.block(lat,lon);
    
    [self.locManager stopUpdatingLocation];
    
}

- (void)getGps:(LocationBlock)block {
    
    self.block = block;
    [self.locManager startUpdatingLocation];
}

@end

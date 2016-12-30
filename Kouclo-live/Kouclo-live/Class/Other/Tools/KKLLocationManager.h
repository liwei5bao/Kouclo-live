//
//  KKLLocationManager.h
//  Kouclo-live
//
//  Created by liwei on 16/12/25.
//  Copyright © 2016年 live. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocation;
typedef void(^LocationBlock)(NSString * lat, NSString * lon);

@interface KKLLocationManager : NSObject
+ (instancetype)sharedManager;

- (void)getGps:(LocationBlock)block;

@property (nonatomic, strong) CLLocation *location;

@property (nonatomic, copy) NSString * lat;
@property (nonatomic, copy) NSString * lon;
@end

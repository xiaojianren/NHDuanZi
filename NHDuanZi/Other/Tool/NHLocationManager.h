//
//  NHLocationManager.h
//  NHDuanZi
//
//  Created by 蚁族 on 2017/3/30.
//  Copyright © 2017年 蚁族. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
typedef void (^NHLocationManagerDidUpLocationHandle)(CLLocation *newLocation,NSString*newLatitude,NSString*newLongitude);

@interface NHLocationManager : NSObject

-(void)startSerialLocation;

+(instancetype)shareManager;

//更新回调
-(void)setUpLocationManagerUpdataLacationHandle:(NHLocationManagerDidUpLocationHandle)updateLocationHandle;
//是否可以定位
@property(nonatomic,assign)BOOL canLocationFlag;
//是否有经纬度
@property(nonatomic,assign)BOOL hasLocation;


@end

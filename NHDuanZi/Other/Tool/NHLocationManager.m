//
//  NHLocationManager.m
//  NHDuanZi
//
//  Created by 蚁族 on 2017/3/30.
//  Copyright © 2017年 蚁族. All rights reserved.
//

#import "NHLocationManager.h"

@interface NHLocationManager ()<AMapLocationManagerDelegate>
@property(nonatomic,strong)AMapLocationManager *locationManager;
@end
static NHLocationManager *_singleton=nil;
@implementation NHLocationManager{
    NHLocationManagerDidUpLocationHandle _updateLocationHandle;
}

+(instancetype)shareManager{
    dispatch_once_t onec;
    dispatch_once(&onec, ^{
        _singleton=[[self alloc]init];
    });
    return _singleton;
}

-(void)setUpLocationManagerUpdataLacationHandle:(NHLocationManagerDidUpLocationHandle)updateLocationHandle{
    _updateLocationHandle=updateLocationHandle;
}
-(void)startSerialLocation{
    if (self.canLocationFlag==NO) {
        return;
    }
    [self.locationManager startUpdatingLocation];
}

-(void)stopSerialLocation{
    [self.locationManager stopUpdatingLocation];
}

#pragma mark---amapLocationdelegate
-(void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error{
    [MBProgressHUD showMessage:[NSString stringWithFormat:@"定位有误:%@",error]];
}
-(void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location{
    NSString *currentLatitude=[[NSString alloc]initWithFormat:@"%f",location.coordinate.latitude];
    NSString *currentLongitude=[[NSString alloc]initWithFormat:@"%f",location.coordinate.longitude];
    [[NSUserDefaults standardUserDefaults]setObject:currentLatitude forKey:kNHUserCurrentLatitude];
    [[NSUserDefaults standardUserDefaults]setObject:currentLongitude forKey:kNHUserCurrentLongitude];
    if (_updateLocationHandle) {
        _updateLocationHandle(location,currentLatitude,currentLongitude);
    }
}

-(AMapLocationManager*)locationManager{
    if (!_locationManager) {
        AMapLocationManager *locationManager=[[AMapLocationManager alloc]init];
        locationManager.delegate=self;
        locationManager.pausesLocationUpdatesAutomatically=NO;
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
        locationManager.allowsBackgroundLocationUpdates = NO;
    }
    return _locationManager;
}
-(BOOL)isCanLocationFlag{
    if ([CLLocationManager locationServicesEnabled]&&([CLLocationManager authorizationStatus]==kCLAuthorizationStatusAuthorizedAlways||[CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)) {
        return YES;
    } else {
        return NO;
    }
}

-(BOOL)hasLocation{
    return [[[NSUserDefaults standardUserDefaults] objectForKey:kNHUserCurrentLongitude] length] && [[[NSUserDefaults standardUserDefaults] objectForKey:kNHUserCurrentLatitude] length];
}


@end

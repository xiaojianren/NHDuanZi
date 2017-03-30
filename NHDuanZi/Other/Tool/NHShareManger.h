//
//  NHShareManger.h
//  NHDuanZi
//
//  Created by 蚁族 on 2017/3/30.
//  Copyright © 2017年 蚁族. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef NS_ENUM(NSUInteger,NHShareType){
    NHShareTypeQQ=1,
    NHShareTypeQZone,
    NHShareTypeWechatSession,
    NHShareTypeWechat,
    NHShareTypeWeibo,
};

@interface NHShareManger : NSObject

+(instancetype)sharedManger;

-(void)shareWithShareType:(NHShareType)shareType image:(NSString*)image url:(NSString*)url content:(NSString*)content controller:(UIViewController*)controller;
-(void)registerAllplatForms;



@end

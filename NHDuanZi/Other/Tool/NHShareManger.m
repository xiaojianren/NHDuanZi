//
//  NHShareManger.m
//  NHDuanZi
//
//  Created by 蚁族 on 2017/3/30.
//  Copyright © 2017年 蚁族. All rights reserved.
//

#import "NHShareManger.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/TencentApiInterface.h>
static NHShareManger *_singleton=nil;

@implementation NHShareManger

+(instancetype)sharedManger{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _singleton=[[self alloc]init];
    });
    return _singleton;
}

-(void)registerAllplatForms{
    [UMSocialData setAppKey:@"57cfeda567e58e275c00102d"];
    [UMSocialData openLog:YES];
    [UMSocialWechatHandler setWXAppId:@"wxc01464912319f82e" appSecret:@"a899820621ce623d835c4caf9381762d" url:@"http://www.jianshu.com/users/3930920b505b/latest_articles"];
}

-(void)shareWithShareType:(NHShareType)shareType image:(NSString *)image url:(NSString *)url content:(NSString *)content controller:(UIViewController *)controller{
    switch (shareType) {
        case NHShareTypeWechatSession:{
            if (![WXApi isWXAppInstalled]) {
                [MBProgressHUD showMessage:@"请先安装微信" toView:controller.view];
                 return;
            }
            UMSocialUrlResource *resoure=[[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToWechatSession] content:content image:[UIImage imageNamed:@"digupicon_review_press_1"] location:nil urlResource:resoure completion:^(UMSocialResponseEntity *response) {
                if (response.responseCode==UMSResponseCodeSuccess) {
                    [self sharedSuccess];
                }
            }];
        }
            break;
        case NHShareTypeWechat:{
            if (![WXApi isWXAppInstalled]) {
                [MBProgressHUD showMessage:@"请先安装微信" toView:controller.view];
                return;
            }
            [UMSocialData defaultData].extConfig.wxMessageType=UMSocialWXMessageTypeImage;
            UMSocialUrlResource *resoure=[[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToWechatTimeline] content:content image:[UIImage imageNamed:@"digupicon_review_press_1"] location:nil urlResource:resoure completion:^(UMSocialResponseEntity *response) {
                if (response.responseCode==UMSResponseCodeSuccess) {
                    [self sharedSuccess];
                }
            }];
        }
            break;
        case NHShareTypeWeibo:{
            if (![WeiboSDK isWeiboAppInstalled]) {
                [MBProgressHUD showMessage:@"请先安装微博" toView:controller.view];
                 return;
            }
            UMSocialUrlResource *resoure=[[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToSina] content:content image:[UIImage imageNamed:@"digupicon_review_press_1"] location:nil urlResource:resoure completion:^(UMSocialResponseEntity *response) {
                if (response.responseCode==UMSResponseCodeSuccess) {
                    [self sharedSuccess];
                }
            }];
        }
            break;
            
        case NHShareTypeQQ:{
            if (![TencentApiInterface isTencentAppInstall:kIphoneQQ]) {
                [MBProgressHUD showMessage:@"请先安装QQ" toView:controller.view];
                 return;
            }
            [UMSocialData defaultData].extConfig.wxMessageType=UMSocialQQMessageTypeImage;
            UMSocialUrlResource *resoure=[[UMSocialUrlResource alloc]initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService]postSNSWithTypes:@[UMShareToQQ] content:content image:[UIImage imageNamed:@"digupicon_review_press_1"] location:nil urlResource:resoure completion:^(UMSocialResponseEntity *response) {
                if (response.responseCode==UMSResponseCodeSuccess) {
                    [self sharedSuccess];
                }
            }];
        }
            break;
        case NHShareTypeQZone:{
            if (![TencentApiInterface isTencentAppInstall:kIphoneQQ]) {
                [MBProgressHUD showMessage:@"QQ没有安装,请先安装QQ" toView:controller.view];
                return ;
            }
            [UMSocialData defaultData].extConfig.qqData.qqMessageType = UMSocialQQMessageTypeImage;
            UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:url];
            [[UMSocialDataService defaultDataService] postSNSWithTypes:@[UMShareToQzone] content:content image:image location:nil urlResource:resource presentedController:controller completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    [self sharedSuccess];
                    NSLog(@"分享成功！");
                }
            }];
        }
            break;
            
        default:
            break;
    }
}
- (void)sharedSuccess {
    
}
@end

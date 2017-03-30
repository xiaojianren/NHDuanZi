//
//  MBProgressHUD+NHAddition.h
//  NHDuanZi
//
//  Created by 蚁族 on 2017/3/30.
//  Copyright © 2017年 蚁族. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (NHAddition)

+(void)showError:(NSString*)error toView:(UIView*)view;

+(void)showSuccess:(NSString*)success toView:(UIView*)view;

+(void)showLoad:(UIView*)view;

+(void)showLoad:(NSString *)text toView:(UIView*)view;

+(void)showMessage:(NSString *)message;

+(void)showMessage:(NSString *)message toView:(UIView *)view;

+(void)showMessage:(NSString *)message toView:(UIView *)view detail:(NSString *)detail;

+(void)hideAllInHUDViews:(UIView*)view;

@end

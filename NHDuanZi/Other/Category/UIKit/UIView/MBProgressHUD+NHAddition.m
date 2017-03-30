//
//  MBProgressHUD+NHAddition.m
//  NHDuanZi
//
//  Created by 蚁族 on 2017/3/30.
//  Copyright © 2017年 蚁族. All rights reserved.
//

#import "MBProgressHUD+NHAddition.h"

@implementation MBProgressHUD (NHAddition)


+(void)show:(NSString*)text icon:(NSString*)icon view:(UIView*)view{
    if (view==nil)view=[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=text;
    hud.customView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    hud.mode=MBProgressHUDModeCustomView;
    hud.removeFromSuperViewOnHide=YES;
    [hud hideAnimated:YES afterDelay:0.7];
}

+(void)showError:(NSString*)error toView:(UIView*)view;{
    [self show:error icon:@"error.png" view:view];
}

+(void)showSuccess:(NSString*)success toView:(UIView*)view;{
    [self show:success icon:@"success.png" view:view];
}

+(void)showLoad:(UIView*)view;{
    [self showLoad:nil toView:view];
}

+(void)showLoad:(NSString *)text toView:(UIView*)view;{
    if (view==nil)view=[UIApplication sharedApplication].keyWindow;
    if (text.length==0) {
        text=@"loading";
    }
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=text;
    hud.backgroundColor=[UIColor colorWithRed:0.41f green:0.46f blue:0.50f alpha:0.600f];
    hud.removeFromSuperViewOnHide=YES;
    [hud hide:YES afterDelay:15];
}

+(void)showMessage:(NSString *)message;{
    [self showMessage:message toView:nil];
}

+(void)showMessage:(NSString *)message toView:(UIView *)view;{
    if (message.length==0)  return;
    if (view==nil)view=[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=message;
    hud.mode=MBProgressHUDModeText;
    hud.margin=10.0f;
    hud.backgroundColor=[UIColor colorWithRed:0.41f green:0.46f blue:0.50f alpha:0.600f];
    hud.layer.cornerRadius=5.0f;
    hud.removeFromSuperViewOnHide=YES;
    [hud hide:YES afterDelay:2.0f];
}

+(void)showMessage:(NSString *)message toView:(UIView *)view detail:(NSString *)detail;{
    if (view==nil)view=[UIApplication sharedApplication].keyWindow;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.label.text=message;
    hud.detailsLabel.text=detail;
    hud.mode=MBProgressHUDModeText;
    hud.margin=10.0f;
    hud.removeFromSuperViewOnHide=YES;
    [hud hide:YES afterDelay:1.8];
}

+(void)hideAllInHUDViews:(UIView*)view;{
    if (view == nil) view = [UIApplication sharedApplication].keyWindow;
    
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

@end

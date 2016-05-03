//
//  SWNotification.m
//  golds
//
//  Created by zhangwt on 16/5/3.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SWNotification.h"
@interface SWNotification()
@property (nonatomic, strong)NSUserNotification *userNotification;
@end
@implementation SWNotification

static SWNotification* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
    }) ;
    return _instance ;
}

- (void)sendNotificationWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailText:(NSString *)detailText contentImage:(NSImage *)image{
    NSUserNotification *notification = [[NSUserNotification alloc] init];//创建通知中心
    _userNotification = notification;
    notification.title = title;
    notification.subtitle = subTitle;
    notification.informativeText = detailText;
    notification.contentImage = image;
    // 设置通知声音
    notification.soundName = NSUserNotificationDefaultSoundName;
    
    //只有当用户设置为提示模式时，才会显示按钮
    notification.hasActionButton = YES;
    notification.actionButtonTitle = @"确定";
    notification.otherButtonTitle = @"取消";
    // 一条通知被创建好了，要让该条通知显示给用户，那么我们就需要通过通知中心将通知递交给用户，代码如下：
    //递交通知
    [[NSUserNotificationCenter defaultUserNotificationCenter] scheduleNotification:notification];
    //设置通知的代理
    [[NSUserNotificationCenter defaultUserNotificationCenter] setDelegate:self];
    
    //删除已经显示过的通知
    //[[NSUserNotificationCenter defaultUserNotificationCenter] removeAllDeliveredNotifications];
}

#pragma mark -NSUserNotificationCenter
//通知已经提交给通知中心
- (void)userNotificationCenter:(NSUserNotificationCenter *)center didDeliverNotification:(NSUserNotification *)notification
{
    NSLog(@"didDeliverNotification");
}
//用户已经点击了通知
- (void)userNotificationCenter:(NSUserNotificationCenter *)center didActivateNotification:(NSUserNotification *)notification
{
    NSLog(@"didActivateNotification");
}

// Sent to the delegate when the Notification Center has decided not to present your notification, for example when your application is front most. If you want the notification to be displayed anyway, return YES.
//returen YES;强制显示(即不管通知是否过多)
- (BOOL)userNotificationCenter:(NSUserNotificationCenter *)center shouldPresentNotification:(NSUserNotification *)notification
{
    return YES;
}

@end

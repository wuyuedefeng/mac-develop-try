//
//  SWNotification.h
//  golds
//
//  Created by zhangwt on 16/5/3.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWNotification : NSObject<NSUserNotificationCenterDelegate>

+(instancetype) shareInstance;

- (void)sendNotificationWithTitle:(NSString *)title subTitle:(NSString *)subTitle detailText:(NSString *)detailText contentImage:(NSImage *)image;

@end

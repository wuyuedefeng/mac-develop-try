//
//  SWStatusItem.h
//  golds
//
//  Created by zhangwt on 16/5/10.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface SWStatusItem : NSStatusItem

+(instancetype) shareInstance;

@property (nonatomic, strong) NSStatusItem *statusItem;
- (void)showIcon:(NSImage *)iconImage title: (NSString *)title;
- (void)showIcon: (NSImage *)iconImage;
- (void)showTitle: (NSString *)title;

- (void) addSelect: (SEL)selector withTarget:(NSObject *)target;

@end

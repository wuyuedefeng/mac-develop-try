//
//  SWStatusItem.m
//  golds
//
//  Created by zhangwt on 16/5/10.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SWStatusItem.h"

@implementation SWStatusItem

static SWStatusItem* _instance = nil;

+(instancetype) shareInstance
{
    static dispatch_once_t onceToken ;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init] ;
        _instance.statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength: NSVariableStatusItemLength];
        [_instance.statusItem setHighlightMode:YES];
    }) ;
    return _instance ;
}

- (void)showIcon:(NSImage *)iconImage title: (NSString *)title{
    [self showIcon:iconImage];
    [self showTitle:title];
}

- (void)showIcon: (NSImage *)iconImage{
    [_instance.statusItem setImage:iconImage];
}

- (void)showTitle: (NSString *)title{
    [_instance.statusItem setTitle:title];
}

- (void) addSelect: (SEL)selector withTarget:(NSObject *)target {
    [_instance.statusItem setAction:selector];
    [_instance.statusItem setTarget:target];
}

@end

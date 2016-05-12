//
//  SWStatusItem.m
//  golds
//
//  Created by zhangwt on 16/5/10.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SWStatusBar.h"
@interface SWStatusBar()

#pragma mark - menu
@property (nonatomic, strong)  NSMenu *statusMenu;

@end
@implementation SWStatusBar

static SWStatusBar* _instance = nil;

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
    [_statusItem setImage:iconImage];
}

- (void)showTitle: (NSString *)title{
    [_statusItem setTitle:title];
}

- (void) addSelect: (SEL)selector withTarget:(NSObject *)target {
    [_statusItem setAction:selector];
    [_statusItem setTarget:target];
}

#pragma mark - 添加菜单
- (void)setCustumMenu{
    self.statusMenu = [[NSMenu alloc] initWithTitle:@""];
    
    [self addCustomMenuItemWithTitle:@"显示" image:nil tag:@2 keyEquivalent:@"s"];
    [self addCustomMenuItemWithTitle:@"退出" image:nil tag:@1 keyEquivalent:@"q"];
    
    [self.statusMenu addItem:[NSMenuItem separatorItem]];
    [self.statusItem setMenu:self.statusMenu];
}
- (void)addCustomMenuItemWithTitle:(NSString *)title image: (NSImage *)icon tag:(NSNumber *)tag keyEquivalent: (NSString *)key {
    NSMenuItem *menuItem = [self.statusMenu addItemWithTitle:title action:@selector(menuItemClick:) keyEquivalent:key];
    [menuItem setImage:icon];
    menuItem.tag = [tag intValue];
    [menuItem setTarget:self];
}
- (void)menuItemClick: (NSMenuItem *)menuItem{
    if(menuItem.tag == 1){
        // 退出
        [NSApp terminate:self];
    }else if (menuItem.tag == 2){
        NSLog(@"show");
    }
}


@end

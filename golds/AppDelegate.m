//
//  AppDelegate.m
//  golds
//
//  Created by zhangwt on 16/5/3.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "AppDelegate.h"
#import "SWStatusItem.h"
@interface AppDelegate ()
    
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[SWStatusItem shareInstance] showIcon:[NSImage imageNamed:@"icon"] title:@"1234.56"];
    [[SWStatusItem shareInstance] addSelect:@selector(clicStatusBarIcon:) withTarget:self];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)clicStatusBarIcon: (id)sender{
    NSLog(@"I be clicked");
}

@end

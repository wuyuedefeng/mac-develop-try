//
//  AppDelegate.m
//  golds
//
//  Created by zhangwt on 16/5/3.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "AppDelegate.h"
#import "SWStatusItem.h"
#import <Cocoa/Cocoa.h>
@interface AppDelegate ()

@property(nonatomic, strong)NSURLSession *session;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[SWStatusItem shareInstance] showTitle:@"golds"];
    [[SWStatusItem shareInstance] addSelect:@selector(clicStatusBarIcon:) withTarget:self];
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(getJSBPrice:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)getJSBPrice: (id)sender{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://login.vip9999.com/?s=api-getgold"]];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:60];
    
    if (!_session){
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        _session = [NSURLSession sessionWithConfiguration:config];
    }
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSURLSessionDataTask *dataTask = [_session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
            if(error){
                NSLog(@"%@", error);
            }else{
                NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[SWStatusItem shareInstance] showTitle:resultDic[@"results"][@"buy"]];
                });
            }
        }];
        [dataTask resume];
    });
}

- (void)clicStatusBarIcon: (id)sender{
    [[NSApplication sharedApplication] terminate:nil]; 
}

@end

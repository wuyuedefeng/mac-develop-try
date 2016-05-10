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
//    [[SWStatusItem shareInstance] showIcon:[NSImage imageNamed:@"icon"] title:@"1234.56"];
//    [[SWStatusItem shareInstance] addSelect:@selector(clicStatusBarIcon:) withTarget:self];
    NSTimer *timer = [NSTimer timerWithTimeInterval:5 target:self selector:@selector(getJSBPrice:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}

- (void)getJSBPrice: (id)sender{
    NSLog(@"123");
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:@"https://login.vip9999.com/?s=api-getgold"]];
    [request setHTTPMethod:@"GET"];
    [request setTimeoutInterval:60];
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:Nil error:nil];
    //NSString* dataStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    if (data){
        NSDictionary *resultDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        if (resultDic && [resultDic isKindOfClass:[NSDictionary class]]){
            [[SWStatusItem shareInstance] showTitle:resultDic[@"results"][@"buy"]];
        }
    }
}

@end

//
//  AppDelegate.m
//  golds
//
//  Created by zhangwt on 16/5/3.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "AppDelegate.h"
#import "SWStatusBar.h"
#import <Cocoa/Cocoa.h>
@interface AppDelegate ()

@property(nonatomic, strong)NSURLSession *session;
@property(nonatomic, assign)NSInteger selBarItemTag;

@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
    // Insert code here to initialize your application
    [[SWStatusBar shareInstance] showTitle:@"golds"];
//    [[SWStatusBar shareInstance] addSelect:@selector(clickStatusBarIcon:) withTarget:self];
    [[SWStatusBar shareInstance] setCustumMenu];
    
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:2 target:self selector:@selector(getPrice:) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)applicationWillTerminate:(NSNotification *)aNotification {
    // Insert code here to tear down your application
}



- (void)clickStatusBarIcon: (id)sender{
    NSLog(@"%@", @"clickStatusBarIcon");
}


#pragma mark - 自定义业务
- (void)clickBarItemWithTag: (NSInteger)tag{
    self.selBarItemTag = tag;
    if (tag == 2){
        [self getPrice:@"http://itrydo.com/ldjPrice" identify:@"伦敦金"];
    }else if (tag == 3){
        [self getPrice:@"http://jry.baidao.com/api/hq/npdata.do?markettype=shj&ids=101,102" identify:@"金大师(卖)"];
    }else if (tag == 4){
        [self getPrice:@"http://jry.baidao.com/api/hq/npdata.do?markettype=shj&ids=101,102" identify:@"金大师(买)"];
    }else if (tag == 5){
        [self getPrice:@"http://itrydo.com/goldPrice" identify:@"黄金钱包"];
    }else if (tag == 6){
        [self getPrice:@"https://login.vip9999.com/?s=api-getgold" identify:@"金生宝"];
    }
}
- (void)getPrice: (id)sender{
    if (!self.selBarItemTag){
        self.selBarItemTag = 4;
    }
    [self clickBarItemWithTag:self.selBarItemTag];
}

- (void)getPrice: (NSString *)urlString identify:(NSString *)identify{
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
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
                    NSString *title = @"...";
                    if ([identify isEqualToString:@"金生宝"]){
                        title = [NSString stringWithFormat:@"%@:%@", identify, resultDic[@"results"][@"buy"]];
                    }
                    else if ([identify isEqualToString:@"伦敦金"]){
                        NSString *subString = [resultDic[@"data"] componentsSeparatedByString:@" "][0];
                        title = [NSString stringWithFormat:@"%@:%@", identify, [subString componentsSeparatedByString:@"#"][1]];
                    } else if ([identify isEqualToString:@"金大师(买)"]){
                        title = [NSString stringWithFormat:@"%@:%@:%@", identify, [(NSArray *)resultDic objectAtIndex:0][@"buy"],  [(NSArray *)resultDic objectAtIndex:1][@"buy"]];
                    } else if ([identify isEqualToString:@"金大师(卖)"]){
                        title = [NSString stringWithFormat:@"%@:%@", identify, [(NSArray *)resultDic objectAtIndex:0][@"sell"]];
                    } else if ([identify isEqualToString:@"黄金钱包"]){
                        title = [NSString stringWithFormat:@"%@:%@", identify, resultDic[@"price"]];
                    }
                    [[SWStatusBar shareInstance] showTitle: title];
                });
            }
        }];
        [dataTask resume];
    });
}

@end

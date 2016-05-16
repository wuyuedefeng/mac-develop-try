//
//  ViewController.m
//  golds
//
//  Created by zhangwt on 16/5/3.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "ViewController.h"
#import "SWNotification.h"
#import "SWView.h"
@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    SWView *view = [[SWView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    
    NSButton *btn = [[NSButton alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    btn.title = @"MyButton";
    [btn setTarget:self];
    [btn setAction:@selector(click)];
    [view addSubview:btn];
    
}

- (void)click{
    NSLog(@"click....");
    SWNotification *swNotification = [SWNotification shareInstance];
    [swNotification sendNotificationWithTitle:@"通知中心" subTitle:@"小标题" detailText:@"详细文字说明" contentImage:[NSImage imageNamed:@"ladybugThumb"]];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (BOOL)isFlipped{
    return YES;
}

@end

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
@interface ViewController()
@property (nonatomic, strong)NSButton *btn;
@end
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    SWView *view = [[SWView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:view];
    
    
    NSButton *btn = [[NSButton alloc] initWithFrame:CGRectMake(0, 100, view.bounds.size.width, 50)];
    _btn.layer.backgroundColor = [[NSColor redColor] CGColor];
    _btn = btn;
    btn.title = @"时间";
    [_btn setFont:[NSFont systemFontOfSize:12.0]];
    [btn setTarget:self];
    [btn setAction:@selector(click)];
    [view addSubview:btn];
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(getLocalTime) userInfo:nil repeats:YES];
    
    NSButton *btn2 = [[NSButton alloc] initWithFrame:CGRectMake(0, 0, 200, 50)];
    btn2.title = @"MyButton";
    [btn2 setTarget:self];
    [btn2 setAction:@selector(click2:)];
    [view addSubview:btn2];

}

- (void)click2: (NSButton *)btn{
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss # SSS"];
    NSString * timeString=[dateformatter stringFromDate:senddate];

    btn.title = timeString;
}

- (void)getLocalTime{
    
    
    //获得系统时间
    NSDate *  senddate=[NSDate date];
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"HH:mm:ss # SSS"];
    NSString * timeString=[dateformatter stringFromDate:senddate];

    NSArray *timeArray = [timeString componentsSeparatedByString: @" # "];
    NSString *ms = timeArray[1];
    NSString *s = [[timeArray[0] componentsSeparatedByString:@":"] lastObject];
    
    
    _btn.title = timeString;
    
    if (([s intValue] == 59 && [ms intValue] > 500) || [s intValue] == 0) {
        [_btn setFont:[NSFont systemFontOfSize:22]];
        NSMutableAttributedString *attrTitle = [[NSMutableAttributedString alloc]
                                                initWithAttributedString:[_btn attributedTitle]];
        long len = [timeString length];
        NSRange range = NSMakeRange(0, len);
        [attrTitle addAttribute:NSForegroundColorAttributeName
                          value:[NSColor redColor]
                          range:range];
        [attrTitle fixAttributesInRange:range];
        [_btn setAttributedTitle:attrTitle];
    }else{
        [_btn setFont:[NSFont systemFontOfSize:12.0]];
    }
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

//
//  SWView.m
//  golds
//
//  Created by zhangwt on 16/5/16.
//  Copyright © 2016年 wangsen. All rights reserved.
//

#import "SWView.h"

@implementation SWView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}


- (BOOL)isFlipped{
    // return YES, 布局按iOS左上方为坐标（0，0）， 默认左下方为（0，0）点
    return YES;
}

@end

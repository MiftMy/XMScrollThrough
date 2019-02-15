//
//  FatherScrollView.m
//  XMScrollThrough
//
//  Created by Mifit on 2019/2/15.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "FatherScrollView.h"

@implementation FatherScrollView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/// 子视图滚动时候，同时响应滚动手势。
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    NSLog(@"+++++++---------");
    return YES;
}
@end

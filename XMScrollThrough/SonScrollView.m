//
//  SonScrollView.m
//  XMScrollThrough
//
//  Created by Mifit on 2019/2/15.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "SonScrollView.h"

@implementation SonScrollView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delegate = self;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (!self.canScroll) {
        scrollView.contentOffset = CGPointZero;
    }
    if (scrollView.contentOffset.y <= 0) { /// 往上滚动时候
        self.canScroll = NO;
        scrollView.contentOffset = CGPointZero;
    }
    self.showsVerticalScrollIndicator = self.canScroll;
}
@end

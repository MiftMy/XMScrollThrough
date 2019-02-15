//
//  ViewController.m
//  XMScrollThrough
//
//  Created by Mifit on 2019/2/15.
//  Copyright © 2019年 Mifit. All rights reserved.
//

#import "ViewController.h"
#import "SonScrollView.h"
#import "FatherScrollView.h"

@interface ViewController () <UIScrollViewDelegate>
{
    FatherScrollView *_fatherScrollview; // 父视图
    SonScrollView *_sonScrollView;       // 子视图
    
    CGFloat _ctHeight; // 父视图滚动到哪就开始滚动子视图
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    /// 父视图
    CGRect rect = self.view.bounds;
    _ctHeight = self.view.bounds.size.height;
    FatherScrollView *scrollview = [[FatherScrollView alloc]initWithFrame:rect];
    scrollview.delegate = self;
    [self.view addSubview:scrollview];
    scrollview.backgroundColor = [UIColor redColor];
    _fatherScrollview = scrollview;
    
    /// 设置父视图contentSize
    CGSize ctSize = rect.size;
    ctSize.height += _ctHeight;
    scrollview.contentSize = ctSize;
    
    
    /// 子视图
    CGRect rect22 = self.view.bounds;
    rect22.origin.y = _ctHeight;
    SonScrollView *second = [[SonScrollView alloc]initWithFrame:rect22];
    [scrollview addSubview:second];
    second.backgroundColor = [UIColor blueColor];
    
    /// 设置子视图contentSize
    second.contentSize = ctSize;
    _sonScrollView = second;
    
    /// 子视图的view
    CGRect temRect = self.view.bounds;
    temRect = CGRectInset(temRect, 10, 20);
    UIView *sView = [[UIView alloc]initWithFrame:temRect];
    sView.backgroundColor = [UIColor greenColor];
    [second addSubview:sView];
    
    /// 子视图的view
    temRect.origin.y += self.view.bounds.size.height;
    UIView *tView = [[UIView alloc]initWithFrame:temRect];
    tView.backgroundColor = [UIColor yellowColor];
    [second addSubview:tView];
    
}

/// 父视图最大滚动到子视图完全显示时候，把滚动传递给子视图。其他正常滚动。
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = _ctHeight;
    /// 父视图滚动时候手势不会穿透给子视图，需要自己实现传递。
    if (scrollView.contentOffset.y >= height) { //  往下滚到指定地方开始滚动子视图（此时子视图不会同时响应手势）。父视图保持height固定位置,然后传递给子视图。
        // 传递滚动给子视图
        CGFloat offsetY = scrollView.contentOffset.y - height;
        CGPoint offset = _sonScrollView.contentOffset;
        offset.y += offsetY;
        CGFloat maxOffsetY = _sonScrollView.contentSize.height - self.view.bounds.size.height;
        if (offset.y > maxOffsetY) {    // 限制不超出子视图的滚动范围
            offset.y = maxOffsetY;
        }
        _sonScrollView.contentOffset = offset;
        
        scrollView.contentOffset = CGPointMake(0, height);  // 父视图保持固定位置
        if (!_sonScrollView.canScroll) {
            _sonScrollView.canScroll = YES;
        }
    } else {
        if (_sonScrollView.canScroll) { // 子视图往上滚动但是没到顶部。
            scrollView.contentOffset = CGPointMake(0, height);
        } else {    // 子视图往上滚动到0位置时候会停止滚动
            // 父视图正常滚动
        }
    }
    _fatherScrollview.showsVerticalScrollIndicator = !_sonScrollView.canScroll;
}
@end

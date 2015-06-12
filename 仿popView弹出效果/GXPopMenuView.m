//
//  GXPopMenuView.m
//  GXWeibo
//
//  Created by GX on 15/5/29.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import "GXPopMenuView.h"

@implementation GXPopMenuView

UIWindow *_window;

// 定义全局变量保存传入的block
dismissBlock _dismiss;

/**
 *  弹出仿pop效果菜单
 *
 *  @param fromView 菜单需要指向哪个控制器
 *  @param content  菜单需要显示的控件
 */
+ (void)popFrom:(UIView *)fromView content:(UIView *)content dismiss:(dismissBlock)dismiss {
    [self popFrom:fromView.frame inView:fromView.superview content:content dismiss:dismiss];
}
/**
 *  弹出仿pop效果菜单
 *  @param fromRect 指向的区域
 *  @param fromView 菜单需要指向哪个控制器
 *  @param content  菜单需要显示的控件
 */
+ (void)popFrom:(CGRect)fromRect inView:(UIView *)inView content:(UIView *)content dismiss:(dismissBlock)dismiss {
    
    _dismiss = [dismiss copy];
    
    // 1.创建窗口
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _window.hidden = NO;
    _window.windowLevel = UIWindowLevelAlert;
    
    // 2.创建蒙版
    UIButton *cover = [[UIButton alloc] init];
    cover.frame = [UIScreen mainScreen].bounds;
    cover.backgroundColor = [UIColor clearColor];
    [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
    [_window addSubview:cover];
    
    // 3.创建菜单
    UIImageView *menuView = [[UIImageView alloc] init];
    UIImage *image = [UIImage imageNamed:@"popover_background"];
    menuView.image = image;
    menuView.userInteractionEnabled = YES;
    [cover addSubview:menuView];
    
    // 4.添加传入的内容到菜单上
    content.x = 15;
    content.y = 18;
    [menuView addSubview:content];
    
    // 5.设置菜单容器的frame
    CGFloat menuViewW = CGRectGetMaxX(content.frame) + content.x;
    CGFloat menuViewH = CGRectGetMaxY(content.frame) + content.y;
    menuView.frame = CGRectMake(0, 0, menuViewW, menuViewH);
    
    // 获取需要指向控件的frame, 并且是转换为和蒙版同一个坐标系的frame
    // 将fromView.frame的坐标系 从 fromView.superview  转换为 _window
    CGRect resultFrame = [_window convertRect:fromRect fromView:inView];
    
    // 设置菜单的Y的值
    menuView.y = CGRectGetMaxY(resultFrame);
    
    /*
     // 获取需要执行控件的center
     CGPoint resultCenter = [_window convertPoint:fromView.center fromView:fromView.superview];
     // 设置菜单的centerX的值
     menuView.centerX = resultCenter.x;
     */
    
    menuView.centerX = resultFrame.origin.x + (resultFrame.size.width * 0.5);
    
    // 显示菜单
    menuView.hidden = NO;
}

/**
 *   弹出仿pop效果菜单
 *
 *  @param fromView  指向的区域
 *  @param contentVc 传入的控制器
 *  @param dismiss   菜单需要显示的控件
 */
UIViewController *_contentVc;
+ (void)popFrom:(UIView *)fromView contentVc:(UIViewController *)contentVc dismiss:(dismissBlock)dismiss {
    // 保命
    _contentVc = contentVc;

    // 显示
    [self popFrom:fromView content:_contentVc.view dismiss:dismiss];

}


+ (void)coverClick:(UIButton *)btn {
    _window = nil;
    
    // 在这里通知调用者
    if (_dismiss != nil) {
        _dismiss();
    }
}
@end

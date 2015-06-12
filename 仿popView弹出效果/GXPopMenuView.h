//
//  GXPopMenuView.h
//  GXWeibo
//
//  Created by GX on 15/5/29.
//  Copyright (c) 2015年 GX. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^dismissBlock)(); // 宏定义了一个block

@interface GXPopMenuView : NSObject
/**
 *  弹出仿pop效果菜单
 *
 *  @param fromView 菜单需要指向哪个控制器
 *  @param content  菜单需要显示的控件
 */
+ (void)popFrom:(UIView *)fromView content:(UIView *)content dismiss:(dismissBlock)dismiss;   // 这里因为在外界传进来值的时候，掉用时会触发别的操作(按钮图片的转换),所以用block或者代理来进行控制器回调的值处理

/**
 *  弹出仿pop效果菜单
 *  @param fromRect 指向的区域
 *  @param inView   传入的参照（以哪里为原点）
 *  @param fromView 菜单需要指向哪个控制器
 *  @param content  菜单需要显示的控件
 */
+ (void)popFrom:(CGRect)fromRect inView:(UIView *)inView content:(UIView *)content dismiss:(dismissBlock)dismiss;

/**
 *   弹出仿pop效果菜单
 *
 *  @param fromView  指向的区域
 *  @param contentVc 传入的控制器
 *  @param dismiss   菜单需要显示的控件
 */
+ (void)popFrom:(UIView *)fromView contentVc:(UIViewController *)contentVc dismiss:(dismissBlock)dismiss;

@end

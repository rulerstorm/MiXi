//
//  IWTabBar.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "IWTabBar.h"
#import "IWTabBarButton.h"
#import "IWTabBarButtonHeart.h"

@interface IWTabBar()
@property (nonatomic, weak) IWTabBarButton *selectedButton;
@end

@implementation IWTabBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:0.098 green:0.1057 blue:0.102 alpha:0.95];
    }
    return self;
}

- (void)addTabBarButtonWithItem:(UITabBarItem *)item
{
    // 1.创建按钮
//    IWTabBarButton *button = [[IWTabBarButton alloc] init];
//    [self addSubview:button];
    
    if ([item.title  isEqual: @"个人中心"]) {
        IWTabBarButtonHeart *button = [[IWTabBarButtonHeart alloc] init];
        [self addSubview:button];
        // 2.设置数据
        button.item = item;
        
        // 3.监听按钮点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        
        // 4.默认选中第0个按钮
        if (self.subviews.count == 1) {
            [self buttonClick:button];
        }
    }else{
        IWTabBarButton *button = [[IWTabBarButton alloc] init];
        [self addSubview:button];
        // 2.设置数据
        button.item = item;
        
        // 3.监听按钮点击
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchDown];
        
        // 4.默认选中第0个按钮
        if (self.subviews.count == 1) {
            [self buttonClick:button];
        }
    }
   
    

}

/**
 *  监听按钮点击
 */
- (void)buttonClick:(IWTabBarButton *)button
{
    // 1.通知代理
    if ([self.delegate respondsToSelector:@selector(tabBar:didSelectedButtonFrom:to:)]) {
        [self.delegate tabBar:self didSelectedButtonFrom:self.selectedButton.tag to:button.tag];
    }
    
    // 2.设置按钮的状态
//    self.selectedButton.selected = NO;
//    button.selected = YES;
//    self.selectedButton = button;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 按钮的frame数据
    CGFloat buttonH = self.frame.size.height;
    CGFloat buttonW = self.frame.size.width / self.subviews.count;
    CGFloat buttonY = 0;
    
    for (int index = 0; index<self.subviews.count; index++) {
        // 1.取出按钮
        IWTabBarButton *button = self.subviews[index];
        
        // 2.设置按钮的frame
        CGFloat buttonX = index * buttonW;
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        
        // 3.绑定tag
        button.tag = index;
    }
}
@end

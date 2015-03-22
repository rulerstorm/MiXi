//
//  IWTabBarButton.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

// 图标的比例
#define IWTabBarButtonImageRatio 0.6


#import "IWTabBarButtonHeart.h"

// 按钮的默认文字颜色
//#define  IWTabBarButtonTitleColor [UIColor colorWithRed:139/255 green:117/255 blue:76/255 alpha:1]
// 按钮的选中文字颜色
//#define  IWTabBarButtonTitleSelectedColor [UIColor colorWithRed:139/255 green:117/255 blue:76/255 alpha:1]

@implementation IWTabBarButtonHeart

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 图标居中
        self.imageView.contentMode = UIViewContentModeCenter;
        // 文字居中
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        // 字体大小
//        self.titleLabel.font = [UIFont systemFontOfSize:12];
        // 文字颜色
//        [self setTitleColor:[UIColor colorWithRed:0.5451 green:0.4882 blue:0.298 alpha:1] forState:UIControlStateNormal];
//        [self setTitleColor:[UIColor colorWithRed:0.5451 green:0.4882 blue:0.298 alpha:1] forState:UIControlStateSelected];

        

    }
    return self;
}

// 重写去掉高亮状态
//- (void)setHighlighted:(BOOL)highlighted {}

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return contentRect;
}

// 内部文字的frame
//- (CGRect)titleRectForContentRect:(CGRect)contentRect
//{
//    CGFloat titleY = contentRect.size.height * IWTabBarButtonImageRatio;
//    CGFloat titleW = contentRect.size.width;
//    CGFloat titleH = contentRect.size.height - titleY;
//    return CGRectMake(0, titleY, titleW, titleH);
//}

// 设置item
- (void)setItem:(UITabBarItem *)item
{
    _item = item;
    
    // KVO 监听属性改变
    [item addObserver:self forKeyPath:@"badgeValue" options:0 context:nil];
    [item addObserver:self forKeyPath:@"title" options:0 context:nil];
    [item addObserver:self forKeyPath:@"image" options:0 context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:0 context:nil];
    
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
}

- (void)dealloc
{
    [self.item removeObserver:self forKeyPath:@"badgeValue"];
    [self.item removeObserver:self forKeyPath:@"title"];
    [self.item removeObserver:self forKeyPath:@"image"];
    [self.item removeObserver:self forKeyPath:@"selectedImage"];
}

/**
 *  监听到某个对象的属性改变了,就会调用
 *
 *  @param keyPath 属性名
 *  @param object  哪个对象的属性被改变
 *  @param change  属性发生的改变
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{

    // 设置文字
//    [self setTitle:self.item.title forState:UIControlStateSelected];
//    [self setTitle:self.item.title forState:UIControlStateNormal];

    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
}
@end

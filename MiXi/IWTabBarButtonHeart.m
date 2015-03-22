//
//  IWTabBarButton.m
//  ItcastWeibo
//
//  Created by apple on 14-5-5.
//  Copyright (c) 2014年 itcast. All rights reserved.
//


#import "IWTabBarButtonHeart.h"

@implementation IWTabBarButtonHeart

// 内部图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    return contentRect;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    // 设置图片
    [self setImage:self.item.image forState:UIControlStateNormal];
    [self setImage:self.item.selectedImage forState:UIControlStateSelected];
    
}

@end

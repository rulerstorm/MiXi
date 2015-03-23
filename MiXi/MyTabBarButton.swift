//
//  MyTabBarButton.swift
//  mixi
//
//  Created by LuRock on 15/3/23.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class MyTabBarButton: UIButton {
    var item :UITabBarItem?{
        willSet{
            if let title = newValue?.title{
                self.setTitle(title, forState: UIControlState.Normal)
            }
            if let image = newValue?.image{
                self.setImage(image, forState: UIControlState.Normal)
            }
            
        }
    }
    
    //从代码创建用这个
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //从xib创建就用这个初始化
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.imageView?.contentMode = UIViewContentMode.Center  //图片中对齐
        self.titleLabel?.textAlignment = NSTextAlignment.Center  //文字中对齐
        self.backgroundColor = UIColor.clearColor()
        self.titleLabel?.font = UIFont.systemFontOfSize(11)  //设定字体大小的绝招
        self.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Normal)
        self.adjustsImageWhenHighlighted = false
        
    }

    //就这两个重载定义了图片和文字的frame，其中contentRect是啥不清楚
    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        let imageW = contentRect.size.width
        let imageH = contentRect.size.height * 0.6
        return CGRect(x: 0, y: 0, width: imageW, height: imageH)
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        let titleY = contentRect.size.height * 0.6
        let titleW = contentRect.size.width
        let titleH = contentRect.size.height - titleY
        return CGRect(x: 0, y: titleY, width: titleW, height: titleH)
    }
    
}
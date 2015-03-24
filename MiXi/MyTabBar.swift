//
//  MyTabBar.swift
//  mixi
//
//  Created by LuRock on 15/3/23.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit


protocol MyTabBarDelegate{
    func tabbarDidSelectButton(#index:Int)
}

class MyTabBar: UIView {

    var delegate :MyTabBarDelegate?
    
    @IBOutlet weak var btnLeft: MyTabBarButton!
    @IBOutlet weak var btnRight: MyTabBarButton!
    @IBOutlet weak var btnHeart: HeartTabBsrButton!
    
    func addTabBarButtonWithItem(#item:UITabBarItem){   //垃圾代码
        if(item.title == "预约车"){
            btnHeart.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchDown)
        }
        if(item.title == "婚礼达人"){
            btnLeft.item = item
            btnLeft.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchDown)
        }
        if(item.title == "婚礼布置"){
            btnRight.item = item
            btnRight.addTarget(self, action: Selector("buttonClick:"), forControlEvents: UIControlEvents.TouchDown)
        }
    }
    
    
    func buttonClick(button:MyTabBarButton){
        var index = 0
        if(button.titleLabel?.text == "婚礼布置"){
            index = 2
        }
        if(button.titleLabel?.text == nil){
            index = 1
        }
        //上面这段垃圾代码用来标示用户点击了哪个按钮，转化成tabbar的序号
        
        self.delegate?.tabbarDidSelectButton(index: index)
    }
    

}

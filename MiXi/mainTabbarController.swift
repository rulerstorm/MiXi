//
//  mainTabbarController.swift
//  mixi
//
//  Created by LuRock on 15/3/21.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class mainTabbarController: UITabBarController, MyTabBarDelegate {

    var customTabBar :MyTabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化自定义的tabbar
        let nib = UINib(nibName: "TabBarView", bundle: nil)
        let newTabBar = nib.instantiateWithOwner(nil, options: nil)[0] as MyTabBar

        newTabBar.delegate = self
//        self.tabBar.frame = CGRect(x: self.tabBar.frame.minX, y: self.tabBar.frame.minY-8, width: self.tabBar.frame.width, height: self.tabBar.frame.height+8)
//        self.tabBar.barTintColor = UIColor.whiteColor()
//        self.tabBar.clipsToBounds = true
        self.view.addSubview(newTabBar)
        self.customTabBar = newTabBar
        newTabBar.frame = CGRect(x: 0, y: self.view.frame.height - 57, width: self.view.frame.width, height: 57)
        //初始化所有子控制器
        self.setupAllChildViewControllers()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBar.removeFromSuperview()
        //删除系统自带的uitabbarbutton
//        for subview in self.tabBar.subviews{
//            if (subview.isKindOfClass(UIControl)){
//                subview.removeFromSuperview()
//            }
//        }
    }
    
    //tabbar回调的代理事件
    func tabbarDidSelectButton(#index :Int) {
        self.selectedIndex = index
    }
    
    func setupAllChildViewControllers(){
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let daRen = storyBoard.instantiateViewControllerWithIdentifier("daren") as DaRenViewController
        self.setupChildViewController(daRen, title: "婚礼达人", imageName: "婚礼达人黄")
        
        let userCenter = storyBoard.instantiateViewControllerWithIdentifier("userCenter") as UserCenterTableViewController
        self.setupChildViewController(userCenter, title: "个人中心", imageName: "购物车")
        
        let buZhi = storyBoard.instantiateViewControllerWithIdentifier("buZhi") as HunLiBuZhiViewController
        self.setupChildViewController(buZhi, title: "婚礼布置", imageName: "婚礼布置黄")
        
    }

    
    func setupChildViewController(  childVc :UIViewController,
                                    title :String,
                                    imageName :String)
    {
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
        
        //包装一个导航控制器
        let navi = MyNavigationViewController(rootViewController: childVc)
        navi.navigationBar.barTintColor = mixiColor.mainPink
        navi.navigationBar.tintColor = mixiColor.mainCoffie

        

        

        
        //加到主控制器
        self.addChildViewController(navi)
        
        //传递item数据，初始化tabbar里面按钮
        self.customTabBar?.addTabBarButtonWithItem(item: childVc.tabBarItem)
    }


}

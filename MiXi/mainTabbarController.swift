//
//  mainTabbarController.swift
//  mixi
//
//  Created by LuRock on 15/3/21.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class mainTabbarController: UITabBarController, IWTabBarDelegate{

    var customTabBar :IWTabBar?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化自定义的tabbar
        let newTabBar = IWTabBar()
        newTabBar.frame = self.tabBar.bounds;
        newTabBar.delegate = self;
        self.tabBar.addSubview(newTabBar)
        self.customTabBar = newTabBar
        
        //初始化所有子控制器
        self.setupAllChildViewControllers()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //删除系统自带的uitabbarbutton
        for subview in self.tabBar.subviews{
            if (subview.isKindOfClass(UIControl)){
                subview.removeFromSuperview()
            }
        }
    }
    
    
    func tabBar(tabBar: IWTabBar!, didSelectedButtonFrom from: Int, to: Int) {
        self.selectedIndex = to
    }
    
    func setupAllChildViewControllers(){
        
        let daRen = DaRenViewController()
        self.setupChildViewController(daRen, title: "婚礼达人", imageName: "婚礼达人黄")
        
        let userCenter = UserCenterTableViewController()
        self.setupChildViewController(userCenter, title: "购物车", imageName: "购物车")
        
        let buZhi = HunLiBuZhiViewController()
        self.setupChildViewController(buZhi, title: "婚礼布置", imageName: "婚礼布置黄")
        
    }

    
    func setupChildViewController(  childVc :UIViewController,
                                    title :String,
                                    imageName :String)
//                                    selectedImageName :String)
    {
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
//        childVc.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        if (childVc.title == "购物车"){
            childVc.tabBarItem.image = UIImage(named: imageName)?.scaleImage(InScale: 0.85)
        }
        
        
        //包装一个导航控制器
        self.addChildViewController(UINavigationController(rootViewController: childVc))
        
        //添加到tabbar内部的按钮
        self.customTabBar?.addTabBarButtonWithItem(childVc.tabBarItem)
    }


}

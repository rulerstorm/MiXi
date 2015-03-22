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
        
        
        
    }
    
    func setupAllChildViewControllers(){
        
        let daRen = DaRenViewController()
        self.setupChildViewController(daRen, title: "达人", imageName: "婚礼达人黄")
        
        
        
    }

    
    func setupChildViewController(  childVc :UIViewController,
                                    title :String,
                                    imageName :String)
//                                    selectedImageName :String)
    {
        childVc.title = title
        childVc.tabBarItem.image = UIImage(named: imageName)
//        childVc.tabBarItem.selectedImage = UIImage(named: selectedImageName)?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        
        //包装一个导航控制器
        self.addChildViewController(UINavigationController(rootViewController: childVc))
        
        //添加到tabbar内部的按钮
        self.customTabBar?.addTabBarButtonWithItem(childVc.tabBarItem)
    }


}

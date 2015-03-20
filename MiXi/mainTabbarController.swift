//
//  mainTabbarController.swift
//  mixi
//
//  Created by LuRock on 15/3/21.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class mainTabbarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tabBar.removeFromSuperview()
        let myTabbar = UIView(frame: self.tabBar.frame)
        myTabbar.backgroundColor = UIColor.blueColor()
        self.view.addSubview(myTabbar)
        
        
    }



}

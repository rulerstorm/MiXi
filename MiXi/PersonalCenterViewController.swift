//
//  PersonalCenterViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class PersonalCenterViewController: UIViewController {

    weak var delegate :leftBarButtunDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置页面的title，这要记笔记！！
        self.title = "个人中心"
        
        //设置左上角item
        let leftItem = UIBarButtonItem(image: UIImage(named: "蜜喜蜜喜－首页_07"), style: UIBarButtonItemStyle.Plain, target: self.delegate, action: Selector("leftBarButtunClicked"))
        self.navigationItem.leftBarButtonItem = leftItem
        //这个是网上查来的。。。好神奇，可以左移item的位置
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
    }

  



}

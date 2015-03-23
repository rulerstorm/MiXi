//
//  MyNavigationViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/24.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

protocol MyNavigationViewControllerDelegate {
    func MyNavigationControllerLeftBarItenClicked()
}


class MyNavigationViewController: UINavigationController {

    var itemDelegate :AnyObject?
    
    
    override func viewDidLoad() {
println("sfsf")
        let leftItem = UIBarButtonItem(image: UIImage(named: "蜜喜蜜喜－首页_07"), style: UIBarButtonItemStyle.Plain, target: self.itemDelegate, action: Selector("MyNavigationControllerLeftBarItenClicked"))
        self.navigationItem.setLeftBarButtonItem(leftItem, animated: true)
    }

}

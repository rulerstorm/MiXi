//
//  SlideViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/22.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class SlideViewController: UIViewController {
    
    let slideBar = SlideBarViewController()
    var mainviewController :UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mainviewController?.view.frame = self.view.bounds   //话说frame和bounds的区别？
        self.slideBar.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.7, height: self.view.frame.height)
        self.view.sendSubviewToBack(slideBar.view)   //这句可以把某个view弄到最底下
        
        //监听手势
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("didDrag"))
        self.mainviewController?.view.addGestureRecognizer(gesture)
    }

    
    func addMainController(mainController :UIViewController){

        self.mainviewController = mainController
        self.addChildViewController(mainController)
        self.view.addSubview(mainController.view)
        self.view.backgroundColor = UIColor.whiteColor()
        
        //为了调试方便，故意加在mainView的上面
        self.addChildViewController(slideBar)
        self.view.addSubview(slideBar.view)
    }

    
    
    

}

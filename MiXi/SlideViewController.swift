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
        self.view.sendSubviewToBack(slideBar.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addMainController(mainController :UIViewController){

        self.addChildViewController(slideBar)
        self.view.addSubview(slideBar.view)
        
        self.mainviewController = mainController
        self.addChildViewController(mainController)
        self.view.addSubview(mainController.view)
        self.view.backgroundColor = UIColor.whiteColor()
        

    }


}

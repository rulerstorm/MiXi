//
//  SlideBarViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/22.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit


protocol SlideBarViewDelegate{
    func changeMainViewToTarget(targetView :String?)
}


class SlideBarViewController: UIViewController {

    var delegate :SlideBarViewDelegate!
    
    @IBOutlet weak var btnMainPage: UIButton!
//    @IBOutlet weak var btnDiscover: UIButton!
//    @IBOutlet weak var btnCustomerCenter: UIButton!
//    @IBOutlet weak var btnUserCenter: UIButton!
    
    @IBAction func allBtnClicked(sender: UIButton) {
        for subview in self.view.subviews{
            if let button = subview as? UIButton{
                button.selected = false
            }
        }
        sender.selected = true
        //这里应该调用主slideViewConroller的代理方法切换主view
        delegate.changeMainViewToTarget(sender.titleLabel?.text)
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnMainPage.selected = true
        
    }


    



}

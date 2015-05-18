//
//  SlideBarViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/22.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit


protocol SlideBarViewDelegate :class{
    func changeMainViewToTarget(targetView :String?)
    func gestureBtnclicked()
}


class SlideBarViewController: UIViewController {

    weak var delegate :SlideBarViewDelegate!
    
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
    

    @IBOutlet weak var avatorImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        btnMainPage.selected = true
        
        if let data = NSData(contentsOfURL: Url!){
            let avator = UIImage(data: data)
            
            //我不知道为什么会自动旋转90度，我还要手动转回来。。。
            avatorImageView.transform = CGAffineTransformMakeRotation(CGFloat(M_PI) * 0.5)
            
            avatorImageView.image = avator
        }
        
    }


    @IBOutlet weak var shadow: UIView!
    

    @IBAction func gestureBtnclicked() {
        delegate.gestureBtnclicked()
    }


}

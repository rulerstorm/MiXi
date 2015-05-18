//
//  ViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/15.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var btnRegist: UIButton!
    @IBOutlet weak var btnLogin: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnRegist.setAsMainTheme()
        btnLogin.setAsMainTheme()
        
        //全局光标颜色
        UITextField.appearance().tintColor = mixiColor.mainCoffie
    }
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func logOnBtnClicked() {
        self.view.endEditing(true)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        let qos = Int( QOS_CLASS_BACKGROUND.value)
        let queue = dispatch_get_global_queue(qos, 0)
        dispatch_async(queue) {
            sleep(1)
            dispatch_async(dispatch_get_main_queue()) {   //UI相关的动作必须切换到主线程
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                let query = AVQuery(className: "_User")
                query.whereKey("username", equalTo: self.passwordTextField.text)
                if(0==query.countObjects()){
                    let test = MBProgressHUD()
                    test.labelText = "昵称或密码错误。请重试~"
                    self.view.addSubview(test)
                    test.center = self.view.center
                    test.show(true)
                    let qos = Int( QOS_CLASS_BACKGROUND.value)
                    let queue = dispatch_get_global_queue(qos, 0)
                    dispatch_async(queue) {
                        sleep(1)
                        dispatch_async(dispatch_get_main_queue()) {   //UI相关的动作必须切换到主线程
                            MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                        }
                    }

                }else{
                    self.performSegueWithIdentifier("logon", sender: nil)
                }
            }
        }
    }
    
    
}


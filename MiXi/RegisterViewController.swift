//
//  RegisterViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/15.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var checkTextField: UITextField!
    @IBOutlet weak var ButtonNext: UIButton!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var textFiedlPhone: UITextField!
    
    //这个方法应该还需要增加发短信的内容
    @IBAction func buttonSendPushed() {

        self.view.endEditing(true)
        
        if(isTelNumber(textFiedlPhone.text)){
            let test = MBProgressHUD()
            test.labelText = "短信发送中……"
            self.view.addSubview(test)
            test.center = self.view.center
            test.show(true)
            
            
            let query = AVQuery(className: "_User")
            query.whereKey("username", equalTo: textFiedlPhone.text)
            if(0==query.countObjects()){
                //开始上网注册
                let qos = Int( QOS_CLASS_BACKGROUND.value)
                let queue = dispatch_get_global_queue(qos, 0)
                dispatch_async(queue) {
                    sleep(2)
                    dispatch_async(dispatch_get_main_queue()) {   //UI相关的动作必须切换到主线程
                        userInfo.realUser.username = self.textFiedlPhone.text
                        userInfo.realUser.password = self.textFiedlPhone.text
                        userInfo.realUser.mobilePhoneNumber = self.textFiedlPhone.text
                        userInfo.realUser.signUp(nil)
                        MBProgressHUD.hideHUDForView(self.view, animated: true)
                    }
                }
            }else{
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                let test = MBProgressHUD()
                test.labelText = "该号码已注册，请登录。"
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
            }

        }else{
            let test = MBProgressHUD()
            test.labelText = "请填写正确手机号码。"
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
        }

        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置底部“下一步”按钮
        ButtonNext.setAsMainTheme()
        //设置“发送”按钮
        buttonSend.setAsMainTheme()
        
        //触摸关闭键盘
        var tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "keyboardHide")
        
        //为啥要加下面这行？参考：http://blog.csdn.net/kylinbl/article/details/9139473
        tapGestureRecognizer.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //自动叫出键盘
        self.textFiedlPhone.becomeFirstResponder()
    }
    
    @IBAction func nextBtnPushed() {
        
        self.performSegueWithIdentifier("register", sender: nil)

        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        AVUser.verifyMobilePhone(checkTextField.text, withBlock: { (succeed, error) -> Void in
            if succeed{
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.performSegueWithIdentifier("register", sender: nil)
            }else{
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                let test = MBProgressHUD()
                test.labelText = "验证码错误"
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
                
            }
        })
    }
    
    //校验手机号码，网上找来的。。。
    func isTelNumber(num:String)->Bool
    {
        var mobile = "^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"
        var  CM = "^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$"
        var  CU = "^1(3[0-2]|5[256]|8[56])\\d{8}$"
        var  CT = "^1((33|53|8[09])[0-9]|349)\\d{7}$"
        var regextestmobile = NSPredicate(format: "SELF MATCHES %@",mobile)
        var regextestcm = NSPredicate(format: "SELF MATCHES %@",CM )
        var regextestcu = NSPredicate(format: "SELF MATCHES %@" ,CU)
        var regextestct = NSPredicate(format: "SELF MATCHES %@" ,CT)
        if ((regextestmobile.evaluateWithObject(num) == true)
            || (regextestcm.evaluateWithObject(num)  == true)
            || (regextestct.evaluateWithObject(num) == true)
            || (regextestcu.evaluateWithObject(num) == true))
        {
            return true
        }
        else
        {
            return false
        }
    }
    
    
    func keyboardHide(){
        self.view.endEditing(true)
    }
    
}





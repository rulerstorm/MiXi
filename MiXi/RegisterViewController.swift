//
//  RegisterViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/15.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var ButtonNext: UIButton!
    @IBOutlet weak var buttonSend: UIButton!
    @IBOutlet weak var textFiedlPhone: UITextField!
    
    //这个方法应该还需要增加发短信的内容
    @IBAction func buttonSendPushed() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        self.view.endEditing(true)
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    //    @IBAction func barItemBackTapped(sender: UIBarButtonItem) {
    //        self.navigationController?.popViewControllerAnimated(true)
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置底部“下一步”按钮
        ButtonNext.setAsMainTheme()
        //设置“发送”按钮
        buttonSend.setAsMainTheme()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //自动叫出键盘
        self.textFiedlPhone.becomeFirstResponder()
    }
    
    
}

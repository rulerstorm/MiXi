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
    
    //这个方法应该还需要增加发短信的内容
    @IBAction func buttonSendPushed() {
        self.view.endEditing(true)
    }
    
    
    override func viewDidLoad() {
        
        //设置底部“下一步”按钮
        let buttonImage = UIImage.resizabelImage(name: "按钮－高72")
        ButtonNext.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        ButtonNext.backgroundColor = nil
        //设置“发送”按钮
        buttonSend.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        buttonSend.backgroundColor = nil
        
        
    }

    
    
    
}

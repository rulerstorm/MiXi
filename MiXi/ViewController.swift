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
}


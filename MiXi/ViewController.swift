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
        let buttonImage = UIImage.resizabelImage(name: "按钮－高72")
        btnRegist.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        btnRegist.backgroundColor = nil
        btnLogin.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        btnLogin.backgroundColor = nil
    }
}


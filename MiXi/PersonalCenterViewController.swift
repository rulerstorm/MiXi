//
//  PersonalCenterViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class PersonalCenterViewController: UIViewController {

    weak var delegate :leftBarButtunDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置页面的title，这要记笔记！！
        self.title = "个人中心"
        
        //设置左上角item
        let leftItem = UIBarButtonItem(image: UIImage(named: "蜜喜蜜喜－首页_07"), style: UIBarButtonItemStyle.Plain, target: self.delegate, action: Selector("leftBarButtunClicked"))
        self.navigationItem.leftBarButtonItem = leftItem
        //这个是网上查来的。。。好神奇，可以左移item的位置
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        //设置各个按钮的边框和圆角。。。
        let coffie = UIColor(red: 165/255, green: 142/255, blue: 100/255, alpha: 0.6).CGColor
        let radius :CGFloat = 7
        
        myShouCangBtn.layer.borderWidth = 1
        myShouCangBtn.layer.cornerRadius = radius
        myShouCangBtn.layer.borderColor = coffie
        
        myBookBtn.layer.borderWidth = 1
        myBookBtn.layer.cornerRadius = radius
        myBookBtn.layer.borderColor = coffie
        
        waitCommentBtn.layer.borderWidth = 1
        waitCommentBtn.layer.cornerRadius = radius
        waitCommentBtn.layer.borderColor = coffie
        
        cleanBtn.layer.borderWidth = 1
        cleanBtn.layer.cornerRadius = radius
        cleanBtn.layer.borderColor = coffie
        
        upDateBtn.layer.borderWidth = 1
        upDateBtn.layer.cornerRadius = radius
        upDateBtn.layer.borderColor = coffie
    }

    @IBOutlet weak var myShouCangBtn: UIButton!
    @IBOutlet weak var myBookBtn: UIButton!
    @IBOutlet weak var waitCommentBtn: UIButton!
    @IBOutlet weak var cleanBtn: UIButton!
    @IBOutlet weak var upDateBtn: UIButton!
    
    
    



}

//
//  DaRenViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/22.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class DaRenViewController: UIViewController {

    @IBOutlet weak var srollView: UIScrollView!
    @IBOutlet weak var btnGuss: UIButton!
    @IBOutlet weak var btnDaRenKu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "蜜喜蜜喜"
        
        //适配iphone4
        self.srollView.contentSize = CGSize(width: 320, height: 568)  //这行表述可滚动范围
        
        //猜你喜欢图片设置
        btnGuss.setBackgroundImage(UIImage.resizabelImage(name: "猜你喜欢底色"), forState: UIControlState.Normal)
        btnDaRenKu.setBackgroundImage(UIImage.resizabelImage(name: "猜你喜欢底色"), forState: UIControlState.Normal)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}

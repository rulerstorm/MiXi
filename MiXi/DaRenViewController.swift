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
    
    var leftItemDelegate :AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "蜜喜蜜喜"

        
        //设置左上角item
        let leftItem = UIBarButtonItem(image: UIImage(named: "蜜喜蜜喜－首页_07"), style: UIBarButtonItemStyle.Bordered, target: self.leftItemDelegate, action: Selector("leftBarButtunClicked"))
        self.navigationItem.leftBarButtonItem = leftItem
        //这个是网上查来的。。。好神奇，可以左移item的位置
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        
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

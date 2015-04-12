//
//  CustomerServiceViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class CustomerServiceViewController: UIViewController {
    
    weak var delegate :leftBarButtunDelegate!
    
    //两个子controller
    var ChatController :InquiryChatTableViewController!
    var ComplainController :ComplainViewController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //设置页面的title，这要记笔记！！
        self.title = "客服中心"
        
        //设置左上角item
        let leftItem = UIBarButtonItem(image: UIImage(named: "蜜喜蜜喜－首页_07"), style: UIBarButtonItemStyle.Plain, target: self.delegate, action: Selector("leftBarButtunClicked"))
        self.navigationItem.leftBarButtonItem = leftItem
        //这个是网上查来的。。。好神奇，可以左移item的位置
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        //从storyBoard中读取两个contorller
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let chat = storyBoard.instantiateViewControllerWithIdentifier("inquiry") as! InquiryChatTableViewController
        let complain = storyBoard.instantiateViewControllerWithIdentifier("complain") as! ComplainViewController
        
        self.ChatController = chat
        self.ComplainController = complain
        
        if self.view.frame.height == 480{
            self.contentView.frame = CGRect(x: 0, y: 125, width: 320, height: 355)
        }
        
        
        
        
        //默认选中“客服咨询”按钮
        inquiryBtnSelected = true
    }
    
    
    @IBOutlet weak var inquiryBtn: UIButton!
    @IBOutlet weak var complainBtn: UIButton!
    @IBOutlet weak var twoBarImageView: UIImageView!
    @IBOutlet weak var contentView: UIView!
    
    var inquiryBtnSelected :Bool = false{
        didSet{
            self.inquiryBtn.selected = inquiryBtnSelected
            if(inquiryBtnSelected){
                self.twoBarImageView.image = UIImage(named: "蜜喜蜜喜－切片iphone5_101")
                
                //这里需要给view设置数据，就是传modle
                
                
                contentView.insertSubview(ChatController.view,atIndex: 0)
            }else{
                self.ChatController.view.removeFromSuperview()
            }
        }
    }
    
    var complainBtnSelected :Bool = false{
        didSet{
            self.complainBtn.selected = complainBtnSelected
            if(complainBtnSelected){
                self.twoBarImageView.image = UIImage(named: "蜜喜蜜喜－切片iphone5_103")
                
                //这里需要给view设置数据，就是传modle
                
                
                contentView.insertSubview(ComplainController.view,atIndex: 0)
            }else{
                self.ComplainController.view.removeFromSuperview()
            }
        }
    }
    

    
    @IBAction func btnInquiryClicked() {
        inquiryBtnSelected = true
        complainBtnSelected = false

    }
    
    @IBAction func btnComplainClicked() {
        inquiryBtnSelected = false
        complainBtnSelected = true
    }

    
    
    
    
    
    



}

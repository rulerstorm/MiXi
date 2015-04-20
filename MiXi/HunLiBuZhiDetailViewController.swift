//
//  HunLiBuZhiDetailViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/20.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class HunLiBuZhiDetailViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let commentView = storyBoard.instantiateViewControllerWithIdentifier("DaRenCommentTableViewController") as! DaRenCommentTableViewController
        self.commentViewController = commentView
        
        individualSayingBtnIsSelected = true
        
        //示范网页，预加载
        let requset = NSURLRequest(URL: NSURL(string: "http://rocklule.me")!)
        myWebViewDetail.loadRequest(requset)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "详情"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.contentSize = CGSize(width: 320*2, height: scrollView.frame.height)
            //取消自动调整，这个很重要，加上去有时候会很奇怪。。。
            self.automaticallyAdjustsScrollViewInsets = false
        }
    }
    
    @IBOutlet weak var topScrollInnerView: UIView!
    
    
    @IBOutlet weak var middleScrollView: UIScrollView!{
        didSet{
            middleScrollView.contentSize = CGSize(width: middleScrollView.frame.width*2, height: middleScrollView.frame.height)
        }
    }

    @IBOutlet weak var contentView: UIView!{
        didSet{
            contentView.layer.cornerRadius = 5
            contentView.layer.borderWidth = 1
            contentView.layer.borderColor = mixiColor.mainCoffie.CGColor
            contentView.layer.masksToBounds = true  //把里面的子view都切掉
        }
    }


    @IBOutlet weak var bookBtn: UIButton!{
        didSet{
            bookBtn.layer.cornerRadius = 3
        }
    }
    
    
    @IBOutlet weak var finalContentView: UIView!
    @IBOutlet weak var barImageView: UIImageView!
    
    @IBOutlet weak var individualSayingBtn: UIButton!
    @IBOutlet weak var themeExplainBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!

    
    var commentViewController :DaRenCommentTableViewController!
    var myWebViewFarse = UIWebView(frame: CGRect(x: 0, y: 0, width: 310, height: 123))
    var myWebViewDetail = UIWebView(frame: CGRect(x: 0, y: 0, width: 310, height: 123))

    
    private var individualSayingBtnIsSelected:Bool = false{
        didSet{
            self.individualSayingBtn.selected = individualSayingBtnIsSelected
            if(individualSayingBtnIsSelected){
                self.barImageView.image = UIImage(named: "详情1")
                UIView.animateWithDuration(0.3, animations: { [unowned self] in
                    self.bookBtn.alpha = 0
                })
                
                
                let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
                myWebViewFarse.loadHTMLString("<html><head><style> body{background-color: #555555}</style></head><body>这里直接提供纯html给商户</body><html>", baseURL: baseURL)
                
                
                
                self.finalContentView.addSubview(self.myWebViewFarse)
            }else{
                self.myWebViewFarse.removeFromSuperview()
            }
        }
    }
    
    private var themeExplainBtnIsSelected:Bool = false{
        didSet{
            self.themeExplainBtn.selected = themeExplainBtnIsSelected
            if(themeExplainBtnIsSelected){
                self.barImageView.image = UIImage(named: "详情2")
                UIView.animateWithDuration(0.3, animations: { [unowned self] in
                    self.bookBtn.alpha = 1
                    })
                
        
//                let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
//                myWebViewDetail.loadHTMLString("<html><head><style> body{background-color: #A58E64}</style></head><body>这里直接提供纯html给商户</body><html>", baseURL: baseURL)
                
                self.finalContentView.addSubview(self.myWebViewDetail)
            }else{
                self.myWebViewDetail.removeFromSuperview()
            }
        }
    }
    

    
    private var commentBtnIsSelected:Bool = false{
        didSet{
            self.commentBtn.selected = commentBtnIsSelected
            if(commentBtnIsSelected){
                self.barImageView.image = UIImage(named: "详情3")
                UIView.animateWithDuration(0.3, animations: { [unowned self] in
                    self.bookBtn.alpha = 1
                    })
//                finalContentView.insertSubview(self.commentViewController.view ,atIndex: 3)
                self.finalContentView.addSubview(self.commentViewController.view)
            }else{
                self.commentViewController.view.removeFromSuperview()
            }
        }
    }
    
    private var moreBtnIsSelected:Bool = false{
        didSet{
            self.moreBtn.selected = moreBtnIsSelected
            if(moreBtnIsSelected){
                self.barImageView.image = UIImage(named: "详情4")
                UIView.animateWithDuration(0.3, animations: { [unowned self] in
                    self.bookBtn.alpha = 0
                    })
            }else{
            }
        }
    }
    
    
    @IBAction func individualClicked(sender: UIButton) {
        individualSayingBtnIsSelected = true
        themeExplainBtnIsSelected = false
        commentBtnIsSelected = false
        moreBtnIsSelected = false
    }
    @IBAction func themeClicked(sender: UIButton) {
        individualSayingBtnIsSelected = false
        themeExplainBtnIsSelected = true
        commentBtnIsSelected = false
        moreBtnIsSelected = false
    }
    @IBAction func commentClicked(sender: UIButton) {
        individualSayingBtnIsSelected = false
        themeExplainBtnIsSelected = false
        commentBtnIsSelected = true
        moreBtnIsSelected = false
    }
    @IBAction func moreClicked(sender: UIButton) {
        individualSayingBtnIsSelected = false
        themeExplainBtnIsSelected = false
        commentBtnIsSelected = false
        moreBtnIsSelected = true
    }
    
    
    
    
    @IBOutlet weak var seeMoreBtn: UIButton!{
        didSet{
            seeMoreBtn.layer.cornerRadius = 3
        }
    }
    
    
    
    
    
   
}

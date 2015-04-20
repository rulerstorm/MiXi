//
//  EnterpriseViewController.swift
//  justSave
//
//  Created by LuRock on 15/4/20.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class EnterpriseViewController: UIViewController, DaRenHeaderViewDelegation {
    

    
    //下面三个小view
    let excelView = DaRenExcelView(frame: CGRect(x: 0, y: 0, width: 320, height: 377))
    //    let workListView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 377))
    var workListViewController :HunLiBuZhiSimpleTableViewController!
    var commentView :DaRenCommentTableViewController!
    
    //三个小view的数据module
    var _excelInfo :photographerInfo?  //解决get方法的循环调用，可能有更好的方法，暂时先这么搞
    var excelInfo :photographerInfo?{
        set{
            self._excelInfo = newValue
        }
        get{    //这里用一个懒加载
            if self._excelInfo==nil {
                //这里应该从网络加载数据
                self._excelInfo = photographerInfo(gender: "男", age: 28, area: "上海 长宁区",
                    expTime: "5 - 10年", expText: "参与拍摄过上千场婚礼现场摄影，作品曾入选《婚礼风尚》杂志；2013年荣获上海市十佳摄影师荣誉称号，金牌人像摄影师。", goodAt: ["欧美系","奢华等"])
            }
            return self._excelInfo
        }
    }
    //下面还有两个module没有写
    //
    //
    
    

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nib = UINib(nibName: "EnterpriseHeaderView", bundle: nil)
        let newNaviBar = nib.instantiateWithOwner(nil, options: nil)[0] as! EnterpriseHeaderView

        let myNavi = self.navigationController as! MyNavigationViewController
        myNavi.changeNewNaviBar(newNaviBar)
        newNaviBar.delegate = self
        
        
        //-----------------3月31日新增，这里开始写页面的主体。
        setUpThreeCheckBar()
        
        //-----------------4月6日新增，这里开始写入“作品列表”的controller
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let workList = storyBoard.instantiateViewControllerWithIdentifier("HunLiBuZhiSimpleTableViewController") as! HunLiBuZhiSimpleTableViewController
        self.workListViewController = workList
        
        
        //-----------------4月7日，这里开始写入“评价”的controller
        let commentTable = storyBoard.instantiateViewControllerWithIdentifier("DaRenCommentTableViewController") as! DaRenCommentTableViewController
        self.commentView = commentTable
        
    }
    
    
    //光这个不行。。。naviController的pop还有一个手势方式。。。
    //重写了popViewControllerAnimated搞定这个问题
    func DaRenHeaderleftItemClicked() {
        //navigation后退
        self.navigationController?.popViewControllerAnimated(true)
        //        //撤下自定义bar
        //        self.myNaviBar?.removeFromSuperview()
        //        //换上备份的老bar
        //        self.navigationController?.view.addSubview(self.backUpView!)
        
        //4月19日新增
        //这个是从收藏那里过来的，我想dismiss自己
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    //-------------------3月31日新增，这里开始写页面的主体。------------------------
    
    @IBOutlet weak var personalInfoBtn: UIButton!
    @IBOutlet weak var listOfWorkBtn: UIButton!
    @IBOutlet weak var commentBtn: UIButton!
    @IBOutlet weak var threeBarImageView: UIImageView!
    
    private var personalInfoIsSelected:Bool = true{
        didSet{
            self.personalInfoBtn.selected = personalInfoIsSelected
            if(personalInfoIsSelected){
                self.threeBarImageView.image = UIImage(named: "蜜喜蜜喜－切片iphone5_104")
                self.excelView._info = self.excelInfo
                contentView.insertSubview(excelView ,atIndex: 0)
            }else{
                self.excelView.removeFromSuperview()
            }
        }
    }
    private var listOfWorkIsSelected:Bool = false{
        didSet{
            self.listOfWorkBtn.selected = listOfWorkIsSelected
            if(listOfWorkIsSelected){
                self.threeBarImageView.image = UIImage(named: "蜜喜蜜喜－切片iphone5_106")
                
                //这里需要给view设置数据，就是传modle
                
                contentView.insertSubview(workListViewController.view ,atIndex: 0)
            }else{
                self.workListViewController.view.removeFromSuperview()
            }
        }
    }
    private var commentIsSelected:Bool = false{
        didSet{
            self.commentBtn.selected = commentIsSelected
            if(commentIsSelected){
                self.threeBarImageView.image = UIImage(named: "蜜喜蜜喜－切片iphone5_105")
                
                //这里需要给view设置数据，就是传modle
                
                
                contentView.insertSubview(commentView.view,atIndex: 0)
            }else{
                self.commentView.view.removeFromSuperview()
            }
        }
    }
    
    @IBAction func btnSelfInfoClicked(sender: UIButton) {
        personalInfoIsSelected = true
        listOfWorkIsSelected = false
        commentIsSelected = false
    }
    
    @IBAction func btnWorkListClicked(sender: UIButton) {
        personalInfoIsSelected = false
        listOfWorkIsSelected = true
        commentIsSelected = false
    }
    
    @IBAction func btnCommentClicked(sender: UIButton) {
        personalInfoIsSelected = false
        listOfWorkIsSelected = false
        commentIsSelected = true
    }
    
    
    private func setUpThreeCheckBar(){
        scrollView.contentSize = CGSize(width: 320, height: 420)
        personalInfoIsSelected = true
        
        //测试用的颜色
        //        self.workListViewController.view.backgroundColor = UIColor.redColor()
        //        self.commentView.backgroundColor = UIColor.blackColor()
        
        
    }
    
    
    //向服务器请求数据
    private func getWorkListFromServer(){
        
    }
    private func getCommentFromServer(){
        
    }
    
    
    
    //------------------------------------------------------
    
    override func viewWillAppear(animated: Bool) {
        //这里需要从网络获取“头像”等数据
        
    }
    
    
    
    
    
    
}














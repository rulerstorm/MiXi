//
//  DaRenDetailViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/24.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class DaRenDetailViewController: UIViewController, DaRenHeaderViewDelegation {

//    var backUpView :UIView?
//    var myNaviBar :DaRenHeaderView?

    
    @IBOutlet weak var threeCheckBar: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var contentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "DaRenHeader", bundle: nil)
        let newNiBar = nib.instantiateWithOwner(nil, options: nil)[0] as DaRenHeaderView
        
        //直接把原来的tabbar干掉就可以了
        //这是我自己摸索出来的方法。。。
//        backUpView = self.navigationController?.view.subviews[1] as? UIView
        //先保存再remove，因为以后退回上一层，还要放上去。。。
//        backUpView!.removeFromSuperview()
        //这里如果直接navigationController.view ＝ newTabBar会使这个页面的整个view消失，只留下newTabBar
        //上面这个navigationController.view的subview数组有俩元素，[0]是整个view，[1]才是默认的tabbar
//        self.navigationController?.view.addSubview(newTabBar)
//        myNaviBar = newTabBar
        //设置代理监听左上角点击事件
//          newTabBar.delegate = self.navigationController as MyNavigationViewController
        //本来这样设置，可以在这个bar传递几个控制器以后直接找到navigationController，但是
        //这个项目这个页面不需要再有深层的push了，所以直接把代理设为self就行
        //更进一步，其实这里根本没有必要定制navigationBar，跳转过来的时候用modula就行了，只是为了练手自定义才这样写
        
        //上面这一坨后来封装到新的［可拆卸更换navibar］的MyNavigationViewController里面去了。。。。
        let myNavi = self.navigationController as MyNavigationViewController
        myNavi.changeNewNaviBar(newNiBar)
        newNiBar.delegate = self
        
        
//-----------------3月31日新增，这里开始写页面的主体。
        self.scrollView.contentSize = CGSize(width: self.view.frame.width, height: 374)
        
        setUpThreeCheckBar()
        
        let excelNib = UINib(nibName: "DaRenExcel", bundle: nil)
        let excelView = excelNib.instantiateWithOwner(nil, options: nil)[0] as DaRenExcelView
        excelView.upDate()
        contentView.insertSubview(excelView ,atIndex: 0)

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
    }



//-------------------3月31日新增，这里开始写页面的主体。------------------------


    private func setUpThreeCheckBar(){
        
        self.threeCheckBar.layer.borderWidth = 0.5
        self.threeCheckBar.layer.borderColor = mixiColor.mainCoffie.CGColor
        self.threeCheckBar.layer.cornerRadius = 12
        //        self.threeCheckBar.layer.masksToBounds = true     //这句话加了和不加有什么区别？？？

        
        
    }



}














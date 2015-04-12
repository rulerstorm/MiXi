//
//  SlideViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/22.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

protocol leftBarButtunDelegate :class{      //class关键字可以让这个协议使用weak指针，原因待查
    func leftBarButtunClicked()
}


class SlideViewController: UIViewController, leftBarButtunDelegate, SlideBarViewDelegate {
    
    private var slideBar :SlideBarViewController!
//    private var mainviewController = mainTabbarController()
    //存放所有可以被侧滑拦切换出来的viewcontroller。字典，key是view的名字，如“个人中心”
    private var mainviewController = [String:UIViewController]()
    //标记活动的controller
    var activeMainViewControler :UIViewController!
    
    //设置初始化多个主页view
    private func setUpMainViewController(){
        //设置主页
        let mainPageViewController = mainTabbarController()
        
        //这个有问题，需要重构
        //功能是各个子页面左上角的barItem设置代理，他们需要通知这个slideViewController来实施侧滑
        for child in mainPageViewController.childViewControllers{
            let navi = child as! UINavigationController
            if(navi.childViewControllers[0] is DaRenViewController){
                let final = navi.childViewControllers[0] as! DaRenViewController
                final.leftItemDelegate = self
            }else if(navi.childViewControllers[0] is HunLiBuZhiViewController){
                let final = navi.childViewControllers[0] as! HunLiBuZhiViewController
                final.leftItemDelegate = self
            }else if(navi.childViewControllers[0] is UserCenterTableViewController){
                let final = navi.childViewControllers[0] as! UserCenterTableViewController
                final.leftItemDelegate = self
            }
        }//for
        
        
        
        //----------------设置个人中心--------------------------------------------------------
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let persionalCenter = storyBoard.instantiateViewControllerWithIdentifier("personalCenter") as! PersonalCenterViewController
        persionalCenter.delegate = self
        
        //包装一个导航控制器
        let persionalCenterNavi = MyNavigationViewController(rootViewController: persionalCenter)
        persionalCenterNavi.navigationBar.barTintColor = mixiColor.mainPink
        //这个是导航控制器左右两个item的主题色
        persionalCenterNavi.navigationBar.tintColor = mixiColor.mainCoffie
        //改所有子bar上面的title颜色，这个字典里面的key和oc中有变化
        persionalCenterNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: mixiColor.mainCoffie]


        //----------------设置客服中心--------------------------------------------------------
        let customerService = storyBoard.instantiateViewControllerWithIdentifier("CustomerService") as! CustomerServiceViewController
        customerService.delegate = self
        
        //包装一个导航控制器
        let customerServiceNavi = MyNavigationViewController(rootViewController: customerService)
        customerServiceNavi.navigationBar.barTintColor = mixiColor.mainPink
        //这个是导航控制器左右两个item的主题色
        customerServiceNavi.navigationBar.tintColor = mixiColor.mainCoffie
        //改所有子bar上面的title颜色，这个字典里面的key和oc中有变化
        customerServiceNavi.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: mixiColor.mainCoffie]
        
        
        
        
        
        self.mainviewController["首页"] = mainPageViewController
        self.mainviewController["个人中心"] = persionalCenterNavi

        self.mainviewController["发现"] = UIViewController()
            self.mainviewController["发现"]?.view.backgroundColor = UIColor.purpleColor()
        
        self.mainviewController["客服中心"] = customerServiceNavi


        
        changeMainViewToTarget("首页")
        
    }
    
    
    
    //用来记录侧滑手势的上一个偏移值
    private var lastX :CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //主view的底色
        self.view.backgroundColor = mixiColor.mainBlack
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        self.slideBar = storyboard.instantiateViewControllerWithIdentifier("SlideBar") as! SlideBarViewController
        self.slideBar.delegate = self
        
        //设置侧边栏的frame
        self.slideBar.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.6, height: self.view.frame.height)
        
        //先加到数组里面的view会在下面
        self.addChildViewController(slideBar)
        self.view.addSubview(slideBar.view)
        self.view.sendSubviewToBack(slideBar.view)   //这句可以把某个view弄到最底下
        
        
        setUpMainViewController()
        
    }//viewDidLoad
    
    //translation不是翻译的意思，意思是“移动量”
    func didDrag(pan:UIPanGestureRecognizer){
        
        let point = pan.translationInView(pan.view!)
        let slideBarWidth = self.slideBar.view.frame.width
        let duration = 0.25
        if let viewFrameMinX = pan.view?.frame.minX{
            if (pan.state == UIGestureRecognizerState.Changed){
                //这里记录上次的位置，以确定拖拽方向
                    self.lastX = viewFrameMinX
            }
            
//            println("lastX:\(self.lastX),,frameX:\(pan.view?.frame.minX)")
            
            // 结束拖拽
            if (pan.state == UIGestureRecognizerState.Cancelled || pan.state == UIGestureRecognizerState.Ended) {
                    if(viewFrameMinX > self.lastX){ //如果向右拖
                        if (viewFrameMinX >= slideBarWidth * 0.2) { // 往右边至少走动了五分之一
                            UIView.animateWithDuration(duration, animations: {
                                pan.view!.transform = CGAffineTransformMakeTranslation(slideBarWidth, 0)
                            })

                        } else{ // 走动距离的没有达到四分之一
                            UIView.animateWithDuration(duration, animations: {
                                pan.view!.transform = CGAffineTransformIdentity   //这个参数需要理解，能复原位置
                            })
                        }
                    }else{
                        if (viewFrameMinX <= slideBarWidth * 0.8) { // 往左边至少走动了五分之一
                            UIView.animateWithDuration(duration, animations: {
                                pan.view!.transform = CGAffineTransformIdentity

                            })
                            
                        } else{
                            UIView.animateWithDuration(duration, animations: {
                                pan.view!.transform = CGAffineTransformMakeTranslation(slideBarWidth, 0)
                            })
                        }
                    }
            } else { // begin和changed都会进来
                    pan.view!.transform = CGAffineTransformTranslate(pan.view!.transform, point.x, 0)
                    pan.setTranslation(CGPointZero, inView: pan.view!)
                    if (pan.view!.frame.minX >= slideBarWidth) {
                        pan.view!.transform = CGAffineTransformMakeTranslation(slideBarWidth, 0);
                    } else if (pan.view!.frame.minX <= 0) {
                        pan.view!.transform = CGAffineTransformIdentity
                    }
            }
        }
    }

    
    //代理方法，监听左上角点击
    func leftBarButtunClicked(){
        self.view.endEditing(true)
        if(self.activeMainViewControler.view.frame.minX == 0){
            UIView.animateWithDuration(0.5, animations: {
                self.activeMainViewControler.view.transform = CGAffineTransformMakeTranslation(self.slideBar.view.frame.width, 0)
            })
        }else{
            UIView.animateWithDuration(0.5, animations: {
                self.activeMainViewControler.view.transform = CGAffineTransformIdentity
            })
        }
    }

    //代理方法，监听左边bar的点击，切换主view
    func changeMainViewToTarget(targetView: String?) {
        
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("didDrag:"))
        
        if let acticeView = self.activeMainViewControler?.view{   //有旧view
            
            //如果点击已经活动的view，那就不要切换了
            if self.activeMainViewControler! == mainviewController[targetView!]!{
                return
            }
            
            //记录目前view的位置，等下交给新view
//          let originTransform = acticeView.frame   //如果这里用frame，则后面手势计算transform的时候会有严重bug
            let originTransform = acticeView.transform
            
            UIView.animateWithDuration(0.5, animations: { [unowned self] in
                acticeView.transform = CGAffineTransformMakeTranslation(self.view.frame.width, 0)
                }, completion: {
                    if $0{
                        //重要问题：手势识别器不能同时被多个view注册，否则只认最后一个view的手势
                        //解除手势
                        acticeView.removeGestureRecognizer(gesture)
                        //去除view
                        acticeView.removeFromSuperview()
                    }
            })
            //这里开始加新view
            if let target = targetView{
                if let targetController = mainviewController[target]{
                    self.view.addSubview(targetController.view)
                    
                    //加入手势
                    targetController.view.addGestureRecognizer(gesture)
                    //一开始从最右边出现
                    targetController.view.transform = CGAffineTransformMakeTranslation(self.view.frame.width, 0)
                    //然后移到原来的位置
                    UIView.animateWithDuration(0.5, animations: { [unowned self] in
                        targetController.view.transform = originTransform
                    })
                    
                    self.activeMainViewControler = targetController
                }
            }
        //没有旧view，就是第一次启动
        }else{
            if let target = targetView{
                if let targetController = mainviewController[target]{
                    self.view.addSubview(targetController.view)
                    //加入手势
                    targetController.view.addGestureRecognizer(gesture)
                    self.activeMainViewControler = targetController
                }
            }
        }
    }
    
}

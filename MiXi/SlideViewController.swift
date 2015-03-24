//
//  SlideViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/22.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

protocol leftBarButtunDelegate{
    func leftBarButtunClicked()
}


class SlideViewController: UIViewController, leftBarButtunDelegate {
    
    let slideBar = SlideBarViewController()
    var mainviewController = mainTabbarController()
    var lastX :CGFloat?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    //这个有问题，需要重构
    //功能是各个子页面左上角的barItem设置代理，他们需要通知这个slideViewController来实施侧滑
    for child in mainviewController.childViewControllers{
        let navi = child as UINavigationController
        if(navi.childViewControllers[0] is DaRenViewController){
            let final = navi.childViewControllers[0] as DaRenViewController
            final.leftItemDelegate = self
        }else if(navi.childViewControllers[0] is HunLiBuZhiViewController){
            let final = navi.childViewControllers[0] as HunLiBuZhiViewController
            final.leftItemDelegate = self
        }else if(navi.childViewControllers[0] is UserCenterTableViewController){
            let final = navi.childViewControllers[0] as UserCenterTableViewController
            final.leftItemDelegate = self
        }

    }

        //设置侧边栏的frame
        self.slideBar.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.6, height: self.view.frame.height)
        
        //监听手势
        let gesture = UIPanGestureRecognizer(target: self, action: Selector("didDrag:"))
        self.mainviewController.view.addGestureRecognizer(gesture)
 
        self.addChildViewController(mainviewController)
        self.view.addSubview(mainviewController.view)
        self.view.backgroundColor = UIColor.whiteColor()

        
        //先加到数组里面的view会在下面
        self.addChildViewController(slideBar)
        self.view.addSubview(slideBar.view)
        self.view.sendSubviewToBack(slideBar.view)   //这句可以把某个view弄到最底下
    }
    
    //里面关于translation的不是恨理解
    func didDrag(pan:UIPanGestureRecognizer){
        let point = pan.translationInView(pan.view!)
        let slideBarWidth = self.slideBar.view.frame.width
        let duration = 0.25
        
        if (pan.state == UIGestureRecognizerState.Changed){
            //这里记录上次的位置，以确定拖拽方向
            self.lastX = pan.view?.frame.minX
        }
        
        // 结束拖拽
        if (pan.state == UIGestureRecognizerState.Cancelled || pan.state == UIGestureRecognizerState.Ended) {
            if(pan.view?.frame.minX > self.lastX!){ //如果向右拖
                if (pan.view?.frame.minX >= slideBarWidth * 0.2) { // 往右边至少走动了五分之一
                    UIView.animateWithDuration(duration, animations: {
                        pan.view!.transform = CGAffineTransformMakeTranslation(slideBarWidth, 0)
                    })

                } else{ // 走动距离的没有达到四分之一
                    UIView.animateWithDuration(duration, animations: {
                        pan.view!.transform = CGAffineTransformIdentity   //这个参数需要理解，能复原位置
                    })
                }
            }else{
                if (pan.view?.frame.minX <= slideBarWidth * 0.8) { // 往左边至少走动了五分之一
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

    
    //代理函数，监听左上角点击
    func leftBarButtunClicked(){
        if(self.mainviewController.view.frame.minX == 0){
            UIView.animateWithDuration(0.5, animations: {
                self.mainviewController.view.transform = CGAffineTransformMakeTranslation(self.slideBar.view.frame.width, 0)
            })
        }else{
            UIView.animateWithDuration(0.5, animations: {
                self.mainviewController.view.transform = CGAffineTransformIdentity
            })
        }
    }

    
    
    

}

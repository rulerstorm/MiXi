//
//  MyNavigationViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/24.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit


//可拆卸更换navibar］的 UINavigationController
//bug，换回去的时候，好像title会跳一下
class MyNavigationViewController: UINavigationController{
    
    var backUpNaviBar : UIView?
    var newNaviBar :UIView?
    
    override func viewDidLoad() {
        //先把这个bar保存起来。。。
        backUpNaviBar = self.view.subviews[1] as? UIView

    }
    
    //重写这个方法，让控制器pop的时候自动换上默认的naviBar
    override func popViewControllerAnimated(animated: Bool) -> UIViewController? {
        if (newNaviBar != nil){
            //先加上备份的bar
            self.view.addSubview(backUpNaviBar!)
            //增加一点动画吧？～～
            //这个方法调用的时候，好像必须执行frame或者transform的变化，否则报的错很奇怪
            UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                self.newNaviBar?.transform = CGAffineTransformMakeTranslation(0, -45)  //上移
                //     self.newNaviBar?.frame = CGRect(x: 0, y: 0, width: 0, height: 0)  //改frame好像没用
                self.newNaviBar?.alpha = CGFloat(0)  //透明
                }, completion: {
                    if $0{      //这个参数是必须的，是一个bool值，表征是否成功执行
                        //去掉自定义的bar
                        self.newNaviBar?.removeFromSuperview()}
            })
        }
        return super.popViewControllerAnimated(animated)
    }


    
    func changeNewNaviBar(newBar :UIView){
        self.backUpNaviBar!.removeFromSuperview()
        //增加淡入效果
        newBar.alpha = CGFloat(0)
        self.view.addSubview(newBar)
        self.newNaviBar = newBar
        //执行动画，为了让这个新bar不要在push前就出现，很碍眼
        UIView.animateWithDuration(0.5, animations: {
            newBar.alpha = CGFloat(1)
        })

    }
    
}

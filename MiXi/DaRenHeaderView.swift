//
//  DaRenHeaderView.swift
//  mixi
//
//  Created by LuRock on 15/3/24.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

protocol DaRenHeaderViewDelegation{
    func DaRenHeaderleftItemClicked()
}


class DaRenHeaderView: UIView {
    //左上角返回按钮的点击代理
    var delegate:DaRenHeaderViewDelegation?
    
    //“加入预约”按钮
    var bookBtn = UIButton.buttonWithType(UIButtonType.System) as UIButton
    
    //从代码创建用这个
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //从xib创建就用这个初始化(这两个初始化要么一起写，要么一起不写)
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        //左上角的“返回”按钮
        let leftItem = UIButton.buttonWithType(UIButtonType.System) as UIButton
        leftItem.setBackgroundImage(UIImage(named: "标题栏－返回iphone5_01"), forState: UIControlState.Normal)
        leftItem.frame = CGRect(x: 2, y: 26, width: 44, height: 44)
        self.addSubview(leftItem)
        leftItem.addTarget(self, action: Selector("LeftBtnClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        
        //“加入预约”按钮
        bookBtn.frame = CGRect(x: 102, y: 125, width: 65, height: 20)
        bookBtn.setTitle("加入预约", forState: UIControlState.Normal)
        bookBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        bookBtn.backgroundColor = mixiColor.brown
        bookBtn.titleLabel?.font = UIFont.boldSystemFontOfSize(11)
        bookBtn.layer.cornerRadius = 3
        self.addSubview(bookBtn)
        
    }
    
    func LeftBtnClicked(){
        self.delegate!.DaRenHeaderleftItemClicked()
    }
    

}

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
    
    var delegate:DaRenHeaderViewDelegation?
    
    //从代码创建用这个
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //从xib创建就用这个初始化(这两个初始化要么一起写，要么一起不写)
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let leftItem = UIButton.buttonWithType(UIButtonType.System) as UIButton

        leftItem.setBackgroundImage(UIImage(named: "标题栏－返回iphone5_01"), forState: UIControlState.Normal)
        leftItem.frame = CGRect(x: 2, y: 25, width: 44, height: 44)
        self.addSubview(leftItem)
        leftItem.addTarget(self, action: Selector("LeftBtnClicked"), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func LeftBtnClicked(){
        self.delegate!.DaRenHeaderleftItemClicked()
    }
    
    

}

//
//  ExtendingUIButton.swift
//  mixi
//
//  Created by LuRock on 15/3/21.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import Foundation

extension UIButton{
    
    func setAsMainTheme(){
        let buttonImage = UIImage.resizabelImage(name: "按钮－高72")
        self.setBackgroundImage(buttonImage, forState: UIControlState.Normal)
        self.backgroundColor = nil
        self.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Highlighted)
    }
    
}
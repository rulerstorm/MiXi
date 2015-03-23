//
//  HeartTabBsrButton.swift
//  mixi
//
//  Created by LuRock on 15/3/23.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class HeartTabBsrButton: MyTabBarButton {

    override func imageRectForContentRect(contentRect: CGRect) -> CGRect {
        return contentRect
    }
    
    override func titleRectForContentRect(contentRect: CGRect) -> CGRect {
        return CGRect(x: 0, y: 0, width: 0, height: 0)
    }


}

//
//  ExtendingUIImage.swift
//  mixi
//
//  Created by LuRock on 15/3/16.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIkit

extension UIImage{
    
    class func resizabelImage(#name :String) ->UIImage?{
        if let normalImage = UIImage(named: name){
            let w = CGFloat(normalImage.size.width * 0.5)
            let h = CGFloat(normalImage.size.width * 0.5)
            return normalImage.resizableImageWithCapInsets(UIEdgeInsets(top: h, left: w, bottom: h, right: w))
        }else{
            return nil
        }
    }
}
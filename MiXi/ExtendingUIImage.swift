//
//  ExtendingUIImage.swift
//  mixi
//
//  Created by LuRock on 15/3/16.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIkit

extension UIImage{
    //返回一张拉伸中央点、不会变形的图片
    class func resizabelImage(#name :String) ->UIImage?{
        if let normalImage = UIImage(named: name){
            let w = CGFloat(normalImage.size.width * 0.5)
            let h = CGFloat(normalImage.size.width * 0.5)
            return normalImage.resizableImageWithCapInsets(UIEdgeInsets(top: h, left: w, bottom: h, right: w))
        }else{
            return nil
        }
    }
    //直接修改图片尺寸
    func scaleImage(#InScale: Float) -> UIImage{
        let newWidth = self.size.width * CGFloat(InScale)
        let newHeight = self.size.height * CGFloat(InScale)
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        self.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func test(){
        UIGraphicsGetCurrentContext()
        
    }

    
    
}
//
//  test.swift
//  mixi
//
//  Created by LuRock on 5/18/15.
//  Copyright (c) 2015 LuRock. All rights reserved.
//

import Foundation


class test {
    func test(){
//        let testQuery = AVQuery.
        
        //关于nsdata与uiimage的互相转化
        
        //这个方法可以转换uiimage为nsdata
        let data = UIImagePNGRepresentation(UIImage())
        //swift里面没有imageWithData，取而代之的是这个构造函数
        UIImage(data: NSData())
        
        
        
        let test = AVObject()

        
        
    }
}
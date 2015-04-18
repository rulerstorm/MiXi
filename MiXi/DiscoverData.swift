//
//  DiscoverData.swift
//  mixi
//
//  Created by LuRock on 15/4/14.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import Foundation


struct DiscoverData{
    var detailed :Bool = false
    let image :UIImage?
    let detailImage :UIImage?
    
    init(image: UIImage?, detail :UIImage?){
        self.image = image
        self.detailImage = detail
    }
}
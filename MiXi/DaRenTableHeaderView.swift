//
//  DaRenTableHeaderView.swift
//  mixi
//
//  Created by LuRock on 15/3/29.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class DaRenTableHeaderView: UIView {


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let nib = UINib(nibName: "DaRenTableHeader", bundle: nil)
        let priceBar = nib.instantiateWithOwner(nil, options: nil)[1] as UIView
        let overAllBar = nib.instantiateWithOwner(nil, options: nil)[2] as UIView
        self.addSubview(priceBar)
        self.addSubview(overAllBar)
        
    }

}

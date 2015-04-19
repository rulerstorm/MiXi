//
//  DaRenTableViewCell.swift
//  mixi
//
//  Created by LuRock on 15/3/28.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

protocol collectionDelegation :class{
    func collectionBtnClicked()
}

//记得设置相框button周围的金色边框
class DaRenTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
        
        
        // Configure the view for the selected state
    }


    @IBAction func mainBtnClicked(sender: UIButton) {
        
        //如果这个值被设置过，说明在收藏的view里面
        if self.collectDelegation != nil{
            self.collectDelegation!.collectionBtnClicked()
        }
        
        
    }
    
    var collectDelegation :collectionDelegation?
}

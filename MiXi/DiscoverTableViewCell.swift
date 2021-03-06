//
//  DiscoverTableViewCell.swift
//  justSave
//
//  Created by LuRock on 15/4/14.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

protocol DiscoverTableViewCellDelegate :class{
    func detailBtnClicked(#rowNmuber:Int)
    func detailBtnCanceled(#rowNmuber:Int)
}


class DiscoverTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //module
    var data :DiscoverData!{
        didSet{
            
        }
    }
    
    var number = 0  //纪录自己是第几行
    
    weak var delegate :DiscoverTableViewCellDelegate!
    
    @IBAction func detailedButtonClicked(sender: UIButton) {
        self.delegate.detailBtnClicked(rowNmuber: number)
    }
    

}

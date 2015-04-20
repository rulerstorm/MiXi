//
//  BookingStatusTableViewCell.swift
//  justSave
//
//  Created by LuRock on 15/4/20.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class BookingStatusTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var alarmToBookingBtn: UIButton!{
        didSet{
            alarmToBookingBtn.layer.cornerRadius = 3
            alarmToBookingBtn.layer.borderWidth = 1
            alarmToBookingBtn.layer.borderColor = mixiColor.mainCoffie.CGColor
        }
        
    }
    
    @IBOutlet weak var outView: UIView!{
        didSet{
            outView.layer.cornerRadius = 4
            outView.layer.borderWidth = 1
            outView.layer.borderColor = mixiColor.mainCoffie.CGColor
            outView.backgroundColor = UIColor.whiteColor()
        }
    }

    @IBOutlet weak var timeLabelBtn: UIButton!{
        didSet{
            timeLabelBtn.setBackgroundImage(UIImage.resizabelImage(name: "我的预约－时间底色iphone5_26"), forState: UIControlState.Normal)
            timeLabelBtn.backgroundColor = UIColor.clearColor()
        }
    }
    
    
    
    
}

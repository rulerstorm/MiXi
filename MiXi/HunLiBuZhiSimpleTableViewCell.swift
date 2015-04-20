//
//  HunLiBuZhiSimpleTableViewCell.swift
//  justSave
//
//  Created by LuRock on 15/4/20.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class HunLiBuZhiSimpleTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var collectBtn: UIButton!{
        didSet{
            collectBtn.layer.cornerRadius = 3
        }
    }
}

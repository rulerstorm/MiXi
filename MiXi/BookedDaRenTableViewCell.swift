//
//  BookedDaRenTableViewCell.swift
//  justSave
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit


class BookedDaRenTableViewCell: BookedBuZhiTableViewCell {


    @IBAction override func BookBtnClicked(sender: UIButton) {
        delegate.bookATime()
    }

}

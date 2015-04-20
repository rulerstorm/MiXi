//
//  BookedBuZhiTableViewCell.swift
//  mixi
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

protocol BookedBuZhiDaRenCellDelegate :class{
    func bookATime()  //参数需要斟酌
}


class BookedBuZhiTableViewCell: UITableViewCell {

    weak var delegate :BookedBuZhiDaRenCellDelegate!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        bookTimeBtn.setAsMainTheme()
        
    }

    
    @IBOutlet weak var bookTimeBtn: UIButton!
    
    @IBAction func BookBtnClicked(sender: UIButton) {

    }
    

}

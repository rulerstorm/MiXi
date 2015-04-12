//
//  ChatTableViewCell.swift
//  mixi
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var bubble: UIButton!
    
    var data :Data!{
        didSet{
            label.text = data.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bubbleImage = UIImage.resizabelImage(name: "蜜喜蜜喜－切片iphone5_58")
        bubble.setBackgroundImage(bubbleImage, forState: UIControlState.Normal)
        
    }




}

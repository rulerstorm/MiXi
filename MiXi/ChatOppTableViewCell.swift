//
//  ChatOppTableViewCell.swift
//  mixi
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class ChatOppTableViewCell: UITableViewCell {

    @IBOutlet weak var bubble: UIButton!
    @IBOutlet weak var label: UILabel!
    
    var data :Data!{
        didSet{
            label.text = data.content
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let bubbleImage = UIImage.resizabelImage(name: "蜜喜蜜喜－切片iphone5_57")
        bubble.setBackgroundImage(bubbleImage, forState: UIControlState.Normal)
    }



}

//
//  ChatData.swift
//  mixi
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import Foundation

struct Data {
    let chatType :Bool  //true客服，false用户
    let content :String
//    let time
    
    //接口message类
    func toMessage()->Message{
        return Message(incoming: self.chatType, text: content)
    }

}

class ChatData{
    var data = [Data]()
    
    init(){
        data.append(Data(chatType: true, content: "您好，请问您有什么疑问呐？"))
    }
    

}
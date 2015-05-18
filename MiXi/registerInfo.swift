//
//  registerInfo.swift
//  mixi
//
//  Created by LuRock on 15/3/18.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import Foundation

class registerInfo{
    enum gender :Int{
        case male
        case female
    }
    
    internal init(){
        userName = nil
        userGender = gender.male
        userBudget = 0
        
        
    }
    
    var userName: String?
    var userGender :gender?
    var userBudget :Int?
    var userStyle = [String]()
    
    let realUser = AVUser()
    
    func saveToDisk(){
        //waiting to fill this part
    }
    
    
    
    
}
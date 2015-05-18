//
//  registerInfo.swift
//  mixi
//
//  Created by LuRock on 15/3/18.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import Foundation


//全局共享用户信息。2015-05-18
let userInfo = registerInfo()


class registerInfo{
    
    var userName = String(){
        didSet{
             realUser["name"] = userName
        }
    }
    
    var userGender :Int?{
        set{
            realUser["userGender"] = newValue
        }
        get{
            if let gender = realUser["userGender"] as? Int{
                return gender
            }else{
                return nil
            }
        }
    }
    var userBudget :Int?{
        set{
            realUser["userBudget"] = newValue
        }
        get{
            if let budget = realUser["userBudget"] as? Int{
                return budget
            }else{
                return nil
            }
        }
    }
    var userStyle = [String]()
    
    var userPhone : String?{
        set{
            realUser["userPhone"] = newValue
        }
        get{
            if let phone = realUser["userPhone"] as? String{
                return phone
            }else{
                return nil
            }
        }
    }
    
    //这里接口网络
    var realUser = AVUser()

    
    func saveToDisk(){
        realUser["userStyle"] = self.userStyle
        realUser.password = realUser.username
        realUser.saveInBackground()
        
        userDefaults.setObject(self.userName, forKey: "userName")
//userDefaults.setObject(self.userName, forKey: "userName")
//        println(userDefaults.objectForKey("userName"))
        
    }

    
    var avator :UIImage?
    
}

let userDefaults = NSUserDefaults.standardUserDefaults()

var searchPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.AllDomainsMask, true)
let Url = NSURL(fileURLWithPath: "\(searchPath[0])/avator.png")
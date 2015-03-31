//
//  DaRenExcelView.swift
//  mixi
//
//  Created by LuRock on 15/4/1.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

struct photographerInfo {
    let gender :String
    let age :Int
    let area :String
    let expTime :String
    let expText :String
    let goodAt :[String]
}

class DaRenExcelView: UIView {
    @IBOutlet weak var webView: UIWebView!

    var info = photographerInfo(gender: "男", age: 28, area: "上海 长宁区",
        expTime: "5 - 10年", expText: "参与拍摄过上千场婚礼现场摄影，作品曾入选《婚礼风尚》杂志；2013年荣获上海市十佳摄影师荣誉称号，金牌人像摄影师", goodAt: ["欧美系","奢华等"])
    let coffieColor = "#A58E64"
    
    //向UIWebView写入数据
    func upDate(){
        //不要问我为啥必须要有这个baseURL，反正没有就报错。。。
        let baseURL = NSURL.fileURLWithPath(NSBundle.mainBundle().bundlePath)
        let style = "、".join(info.goodAt)    //swift小技巧
        //这段html真是让人奔溃。。。
        let data = "<html><head><style>.exp{vertical-align:top;padding-top:5px;padding-bottom:5px;} .gray{color:#555555} .write{color:#FFFFFF}.gold{color:\(coffieColor);} table{font-weight:bold; font-size:12px; border-right:1px solid \(coffieColor); border-left:1px solid \(coffieColor); border-bottom:1px solid \(coffieColor)} td{height:29px; width:50%; border-top:1px solid \(coffieColor)}</style></head><body><table cellspacing='0' cellpadding='0'><tr><td class='gray'>&nbsp&nbsp性别</td><td class='gold'>\(info.gender)</td></tr><tr bgcolor='\(coffieColor)'><td class='gray'>&nbsp&nbsp年龄</td><td class='write'>\(info.age)</td></tr><tr><td class='gray'>&nbsp&nbsp区域</td><td class='gold'>\(info.area)</td></tr><tr bgcolor='\(coffieColor)'><td class='gray'>&nbsp&nbsp从业年数</td><td class='write'>\(info.expTime)</td></tr><tr><td class='gray exp'>&nbsp&nbsp个人经历</td><td class='gold exp'>\(info.expText)</td></tr><tr bgcolor='\(coffieColor)'><td class='gray'>&nbsp&nbsp擅长风格</td><td class='write'>\(style)</td></tr></table></body></html>"
        webView.loadHTMLString(data, baseURL: baseURL)
    }


}

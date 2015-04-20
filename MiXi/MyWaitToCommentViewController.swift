//
//  MyWaitToCommentViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/19.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class MyWaitToCommentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var tableView: UITableView!

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 5
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0{
            let cell :BookedBuZhiTableViewCell
            cell = tableView.dequeueReusableCellWithIdentifier("bookedBuZhi", forIndexPath: indexPath) as! BookedBuZhiTableViewCell
//            cell.delegate = self
            
            return cell
        }else{
            let cell :BookedDaRenTableViewCell
            cell = tableView.dequeueReusableCellWithIdentifier("BookedDaRen", forIndexPath: indexPath) as! BookedDaRenTableViewCell
//            cell.delegate = self
            
            return cell
        }
        
    }

    //组分割view
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let hederView = UIView()
        hederView.backgroundColor = UIColor.whiteColor()
        let label = UILabel()
        label.frame = CGRect(x: 265, y: 0, width: 55, height: 20)
        label.font = UIFont.systemFontOfSize(12)
        label.textColor = UIColor(red: 60/255, green: 60/255, blue: 60/255, alpha: 1)
        hederView.addSubview(label)
        
        if section == 0 {
            label.text = "婚礼布置"
        }else{
            label.text = "婚礼达人"
        }
        return hederView
    }
    
    
    
    
    
    
    

}

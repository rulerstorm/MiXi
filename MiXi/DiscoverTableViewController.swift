//
//  DiscoverTableViewController.swift
//  justSave
//
//  Created by LuRock on 15/4/14.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class DiscoverTableViewController: UITableViewController, DiscoverTableViewCellDelegate {

    var cellData = [DiscoverData]()
    
    
    //模拟数据
    func simulateData(){
        for index in 0...9{
            cellData.append(DiscoverData(image: nil, detail: nil))
//            if index == 3{
//                cellData[3].detailed = true
//            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.title = "发现"
    }
    
    //左上角代理
    weak var leftItemDelegate :AnyObject!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        simulateData()
        
        
        
        //设置左上角item
        let leftItem = UIBarButtonItem(image: UIImage(named: "蜜喜蜜喜－首页_07"), style: UIBarButtonItemStyle.Plain, target: self.leftItemDelegate, action: Selector("leftBarButtunClicked"))
        self.navigationItem.leftBarButtonItem = leftItem
        //这个是网上查来的。。。好神奇，可以左移item的位置
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return cellData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if cellData[indexPath.row].detailed{  //detailed的版本
            let cell = tableView.dequeueReusableCellWithIdentifier("discoverDetailedCell", forIndexPath: indexPath) as! DiscoverDetailedTableViewCell
            // Configure the cell...
            cell.number = indexPath.row
            cell.delegate = self
            return cell
        }else{              //普通的版本
            let cell = tableView.dequeueReusableCellWithIdentifier("discoverCell", forIndexPath: indexPath) as! DiscoverTableViewCell
            // Configure the cell...
            cell.number = indexPath.row
            cell.delegate = self
        
            return cell
        }
    }

    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        println("aaaa")
        if cellData[indexPath.row].detailed{
//            println("ssss")
            return self.tableView.rowHeight * 2
        }
        return self.tableView.rowHeight
    }

    

    //--------------------代理-----------------------
    func detailBtnClicked(#rowNmuber: Int) {
        self.cellData[rowNmuber].detailed = true
//        self.tableView.reloadData()
        
        //刷新制定的行，注意是一个数组，而且可以有动画，赞！
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: rowNmuber, inSection: 0)] , withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    func detailBtnCanceled(#rowNmuber: Int) {
        self.cellData[rowNmuber].detailed = false
//        self.tableView.reloadData()
        self.tableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: rowNmuber, inSection: 0)] , withRowAnimation: UITableViewRowAnimation.Automatic)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

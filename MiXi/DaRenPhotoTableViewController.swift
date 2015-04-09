//
//  DaRenPhotoTableViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/7.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

protocol DaRenPhotoTableViewDelegation{
    func photoClicked()
}



class DaRenPhotoTableViewController: UITableViewController {
    
    var delegation :DaRenPhotoTableViewDelegation!
    
    @IBAction func btnPhotoClicked(sender: UIButton) {
        delegation.photoClicked()
        
        UIView.animateWithDuration(0.5, animations: {[unowned self] in
            
            //这里以后应该是自定义的可以滚动照片的view
            let bigView = UIView(frame: CGRect(x: sender.frame.minX , y: sender.frame.minY + 190, width: sender.frame.width, height: sender.frame.height))
            bigView.backgroundColor = sender.backgroundColor
            bigView.tag = 99
            let susu = self.view.superview!.superview!.superview! as UIView
            susu.addSubview(bigView)
            UIView.animateWithDuration(1, animations: {
                bigView.frame = CGRect(x: 10, y: 220, width: 300, height: 200)
            })
            })
        

    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        NSLog("111111")
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
//        NSLog("2222222")
        
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
//        NSLog("333333")
        
        
        return 55
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DaRenPhotoCell", forIndexPath: indexPath) as DaRenPhotoTableViewCell

        // Configure the cell...

        return cell
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
//
//  MyBookingViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/19.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class MyBookingViewController: UIViewController {

    var BookingStatus :BookingStatusTableViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let hunLiBuZhi = storyBoard.instantiateViewControllerWithIdentifier("BookingStatusTableViewController") as! BookingStatusTableViewController
        self.BookingStatus = hunLiBuZhi
        
        self.contentView.addSubview(BookingStatus.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var contentView: UIView!

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

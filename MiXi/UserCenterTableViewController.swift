//
//  UserCenterTableViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/22.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class UserCenterTableViewController: UIViewController, BookedBuZhiDaRenCellDelegate{

    weak var leftItemDelegate :AnyObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //设置datePicker的外观
        datePickerBtn.setAsMainTheme()
        bookDateView.layer.cornerRadius = 4
        bookSucceedView.layer.cornerRadius = 4
        bookDateView.layer.masksToBounds = true
        bookSucceedView.layer.masksToBounds = true
        
        
        //设置左上角item
        let leftItem = UIBarButtonItem(image: UIImage(named: "蜜喜蜜喜－首页_07"), style: UIBarButtonItemStyle.Plain, target: self.leftItemDelegate, action: Selector("leftBarButtunClicked"))
        self.navigationItem.leftBarButtonItem = leftItem
        //这个是网上查来的。。。好神奇，可以左移item的位置
        self.navigationItem.leftBarButtonItem?.imageInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

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
            cell.delegate = self
            
            return cell
        }else{
            let cell :BookedDaRenTableViewCell
            cell = tableView.dequeueReusableCellWithIdentifier("BookedDaRen", forIndexPath: indexPath) as! BookedDaRenTableViewCell
            cell.delegate = self

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
    

    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var datePickerBtn: UIButton!
    
    @IBOutlet weak var bookDateView: UIView!
    @IBOutlet weak var bookSucceedView: UIView!
    
    @IBAction func dateCancelBtn() {
        UIView.animateWithDuration(0.5, animations: {[unowned self] in
            self.maskView.alpha = 0
            }, completion: {
                if $0{
                    self.bookDateView.alpha = 1
                    self.bookSucceedView.alpha = 0
                }
        })
    }
    @IBAction func datePicked() {
        UIView.animateWithDuration(0.1, animations: {[unowned self] in
            self.bookDateView.alpha = 0
            }, completion: {
                if $0{
                    MBProgressHUD.showHUDAddedTo(self.view, animated: true)
                }
        })
        
        //开另一个线程睡眠3秒模拟网络
        let qos = Int( QOS_CLASS_BACKGROUND.value)
        let queue = dispatch_get_global_queue(qos, 0)
        dispatch_async(queue) {
            sleep(2)
            dispatch_async(dispatch_get_main_queue()) {   //UI相关的动作必须切换到主线程
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                UIView.animateWithDuration(0.3, animations: {[unowned self] in
                    self.bookSucceedView.alpha = 1
                })
            } }
        
    }
    
    // MARK: - table cell 的点击代理方法
    func bookATime() {
        UIView.animateWithDuration(0.5, animations: {[unowned self] in
            self.maskView.alpha = 1
            })
    }
 

}

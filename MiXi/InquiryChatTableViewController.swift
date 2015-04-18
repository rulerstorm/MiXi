//
//  InquiryChatTableViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class InquiryChatTableViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var chatBarView: UIView!
    @IBOutlet weak var inputTextField: UITextField!
    @IBOutlet weak var sendBtn: UIButton!
    @IBAction func btnSendClicked() {
        self.view.endEditing(true)
        self.chatData.data.append(Data(chatType: false, content: inputTextField.text))
        inputTextField.text = nil
        self.tableView.reloadData()


        //假装有人回复。。。。
        let qos = Int( QOS_CLASS_USER_INTERACTIVE.value)
        let queue = dispatch_get_global_queue(qos, 0)
        dispatch_async(queue) {
            sleep(2)
            self.chatData.data.append(Data(chatType: true, content: "好的，您的问题已经收到，我们会尽快处理。谢谢您的反馈！"))
            dispatch_async(dispatch_get_main_queue()) {   //UI相关的动作必须切换到主线程
                self.tableView.reloadData()
                self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.chatData.data.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            }
        }
        
    }
    
    private let chatData = ChatData()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //这里ip4还是有点问题
        if self.view.frame.height == 480{
            self.chatBarView.transform = CGAffineTransformMakeTranslation(0, -88)
//            self.chatBarView.frame = CGRect(x: 0, y: 316, width: 320, height: 38)
        }
        
        inputTextField.delegate = self
        sendBtn.setAsMainTheme()
        
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //监听键盘事件
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillChangeFrame:"), name: "UIKeyboardWillChangeFrameNotification", object: nil)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.chatData.data.count
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
//        if self.chatData.data[indexPath.row].chatType{  //如果是服务员对话
//            let cell = tableView.dequeueReusableCellWithIdentifier("chat", forIndexPath: indexPath) as! ChatTableViewCell
//            cell.data = self.chatData.data[indexPath.row]
//            return cell
//        }else{
//            let cell = tableView.dequeueReusableCellWithIdentifier("chatOpp", forIndexPath: indexPath) as! ChatOppTableViewCell
//            cell.data = self.chatData.data[indexPath.row]
//            return cell
//        }
        
        let cellIdentifier = NSStringFromClass(MessageBubbleCell)
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as! MessageBubbleCell!
        if cell == nil {
            cell = MessageBubbleCell(style: .Default, reuseIdentifier: cellIdentifier)
            
            // Add gesture recognizers #CopyMessage
            let action: Selector = "messageShowMenuAction:"
            let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: action)
            doubleTapGestureRecognizer.numberOfTapsRequired = 2
            cell.bubbleImageView.addGestureRecognizer(doubleTapGestureRecognizer)
            cell.bubbleImageView.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: action))
        }
//        let message = chat.loadedMessages[indexPath.section][indexPath.row-1]
        cell.configureWithMessage(self.chatData.data[indexPath.row].toMessage())
        return cell

        
        
    }

    
    //弹出键盘时同时向上滚动view
    func keyboardWillChangeFrame(note :NSNotification){
        let userInfo = note.userInfo!
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        let transformY = keyboardFrame!.origin.y - self.view.frame.size.height
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        
        if chatData.data.count > 3{
            UIView.animateWithDuration(duration, animations: {
                self.view.transform = CGAffineTransformMakeTranslation(0, transformY)
                }, completion:{
                    if $0{
                        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.chatData.data.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    }
            });
        }else{
            UIView.animateWithDuration(duration, animations: {
                self.chatBarView.transform = CGAffineTransformMakeTranslation(0, transformY)
                }, completion:{
                    if $0{
                        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: self.chatData.data.count-1, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
                    }
                }
            )
        }
     
    }

    var lastY :CGFloat = 0
    
    //监听tableview的滑动，向上滑动不回收，向下要回收
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y >= lastY{
            lastY = scrollView.contentOffset.y
            return
        }
        lastY = scrollView.contentOffset.y
        self.view.endEditing(true)
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        btnSendClicked()
        return true
    }
    
    
    //呵呵，那个气泡对话的库要调用这个函数。。。我也不知道它在哪里添加的，就给你调用吧。。。
    func messageShowMenuAction(ss:AnyObject){
//        println("dd")
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

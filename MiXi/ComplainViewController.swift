//
//  ComplainViewController.swift
//  justSave
//
//  Created by LuRock on 15/4/12.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class ComplainViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //监听键盘事件
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillChangeFrame:"), name: "UIKeyboardWillChangeFrameNotification", object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //弹出键盘时同时向上滚动view
    func keyboardWillChangeFrame(note :NSNotification){
        let userInfo = note.userInfo!
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        let transformY = keyboardFrame!.origin.y - self.view.frame.size.height
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double

        UIView.animateWithDuration(duration, animations: {
            self.view.transform = CGAffineTransformMakeTranslation(0, transformY)
        });
  
    }
    

    @IBAction func cancelBtnClicked() {
        UIView.animateWithDuration(0.3, animations: {[unowned self] in
            self.pupUpView.alpha = 0
            })
    }
    
    @IBAction func sendBtnClicked() {
        
        self.view.endEditing(true)

        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        //开另一个线程睡眠3秒模拟网络
        let qos = Int( QOS_CLASS_BACKGROUND.value)
        let queue = dispatch_get_global_queue(qos, 0)
        dispatch_async(queue) {
            sleep(2)
            dispatch_async(dispatch_get_main_queue()) {   //UI相关的动作必须切换到主线程
                MBProgressHUD.hideAllHUDsForView(self.view, animated: true)
                UIView.animateWithDuration(0.3, animations: {[unowned self] in
                    self.pupUpView.alpha = 1
                    })
            }
        }
        
    }
    
    @IBOutlet weak var pupUpView: UIView!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

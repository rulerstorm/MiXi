//
//  InputInfomationViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/17.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit


class InputInfomationViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate,  UINavigationControllerDelegate{

//    @IBOutlet var scrollView: UIScrollView!
    
    @IBOutlet weak var buttonMale: UIButton!
    @IBOutlet weak var buttonFemail: UIButton!
    
    @IBOutlet weak var buttonComplete: UIButton!

    @IBOutlet weak var textNikname: UITextField!
    @IBOutlet weak var textBudget: UITextField!
    @IBOutlet weak var lableStyle: UITextField!
    @IBOutlet weak var labelHotRecommand: UILabel!
    
    //保存数据的方法
    private func saveToModule(){
        userInfo.userName = textNikname.text
        userInfo.userGender = (buttonMale.selected) ? 1 : 0
        userInfo.userBudget = textBudget.text?.toInt()
//        userInfo.userStyle 这个随时保存
        
        userInfo.saveToDisk()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //触摸关闭键盘
        var tapGestureRecognizer:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "keyboardHide")
        
        //为啥要加下面这行？参考：http://blog.csdn.net/kylinbl/article/details/9139473
        tapGestureRecognizer.cancelsTouchesInView = false;
        self.view.addGestureRecognizer(tapGestureRecognizer)
        
        
        
        
        //设置底部“完成”按钮
        buttonComplete.setAsMainTheme()
        
        //取消男女按钮的高亮阴影
        self.buttonMale.adjustsImageWhenHighlighted = false
        self.buttonFemail.adjustsImageWhenHighlighted = false

        //设置textfield代理
        textBudget.delegate = self
        textNikname.delegate = self
        lableStyle.delegate = self
        
        
        //监听键盘事件
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillChangeFrame:"), name: "UIKeyboardWillChangeFrameNotification", object: nil)
        
        //－－－－－－－－－－－－－－－这里开始计算生成下面的八个“风格”按钮－－－－－－－－－－－－－－－
        let isIphone4 = (UIScreen.mainScreen().bounds.size.height == 480) ? 1 : 0  //对苦逼的iphton4适配
        
        //后记：其实应该在大view里面弄个scrollView，然后就能适配ip4了，现在控件都autolayout，改起来困难了
        
        let gapW :CGFloat = 10
        let gapH :CGFloat = 10
        let btnW :CGFloat = (self.view.frame.size.width - 5 * gapW) / 4
        let btnH :CGFloat = 36
        
        //计算第一个推荐按钮“梦幻”的高度
        let firstHight :CGFloat = self.view.frame.size.height - 70 - CGFloat(2 - isIphone4) * btnH - gapH + CGFloat(isIphone4 * 2) * gapH
        
        //适配iphone4屏幕长度不够的情况
        if ( isIphone4 == 1){
            labelHotRecommand.hidden = true
        }
        
        //这里用代码生成八个按钮
        let btnName = ["梦幻", "小清新", "奢华", "复古", "童话", "另类", "中国风", "宫廷风"]
        for index in 0..<(8 - isIphone4 * 4){    //默认8个，如果iphone4则4个
            let floatIndex = CGFloat(index)
            let realX = (floatIndex % 4 + 1) * gapW + floatIndex % 4 * btnW
            let realY = firstHight + CGFloat(index / 4) * ( gapH + btnH)
            let btn = UIButton.buttonWithType(UIButtonType.System) as! UIButton
            btn.frame = CGRectMake(realX, realY, btnW, btnH)
            btn.setTitle(btnName[index], forState: UIControlState.Normal)
            self.view.addSubview(btn)
            btn.layer.cornerRadius = 4
            btn.layer.borderColor = mixiColor.mainCoffie.CGColor
            btn.layer.borderWidth = 0.5
            btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Normal)
            btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Highlighted)
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
            let buttonImage = UIImage.resizabelImage(name: "按钮－高72")
            btn.setBackgroundImage(buttonImage, forState: UIControlState.Selected)
            btn.addTarget(self, action:Selector("hotBtnPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }//viewdidload()
    
    
    // 控制器销毁时，移除消息通知监听(必须)
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self);
    }

    
    //这里是下面一坨代码创建按钮的点击事件
    func hotBtnPressed(sender :UIButton){    //这里如果sender参数前面加＃会无法识别selector。。。哭
        sender.selected = !sender.selected
        if sender.selected {
            userInfo.userStyle.append(sender.titleLabel!.text!)
        }else{
            for i in 0..<userInfo.userStyle.count{
                //小心删除元素之后，下标i超过原来的最大值count－1越界
                if  userInfo.userStyle[i] == sender.titleLabel!.text!{
                    userInfo.userStyle.removeAtIndex(i)
                    break
                }
            }
        }
        lableStyle.text = nil
        for item in userInfo.userStyle{
            if !lableStyle.text.isEmpty{     //这里用text != nil 好像不行
                lableStyle.text = "\(lableStyle.text)、\(item)"
            }else{
                lableStyle.text = item
            }
        }
        self.view.endEditing(true)
    }
    
    
    //这个是用来模拟“男””女“按钮的代码
    @IBAction func buttonGenderTapped(sender: UIButton) {
        if sender.titleLabel?.text == " 男" {  //注意“男”前面有个空格
            buttonMale.selected = true
            buttonFemail.selected = false
        }else{
            buttonMale.selected = false
            buttonFemail.selected = true
        }
        self.view.endEditing(true)
        self.saveToModule()
    }

    
    //弹出键盘时同时向上滚动view
    func keyboardWillChangeFrame(note :NSNotification){
        var shift :CGFloat = 0
        if textNikname.editing == true{         //第一个输入不要滑动，但是知道怎么判定，出此下策
            shift = 200
        }
        let userInfo = note.userInfo!
        let keyboardFrame = userInfo[UIKeyboardFrameEndUserInfoKey]?.CGRectValue()
        let transformY = keyboardFrame!.origin.y - self.view.frame.size.height
        let duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! Double
        if transformY == 0 {    //这句是垃圾，为了修正前面那个shift＝200。。。
            shift = 0
        }
        UIView.animateWithDuration(duration, animations: {
            self.view.transform = CGAffineTransformMakeTranslation(0, transformY + shift)
        });
    }
    
    
//-----------------textField监听事件----------------------------------
    
    //  点击了return按钮(键盘最右下角的按钮)就会调用
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textBudget.becomeFirstResponder()
        return true
    }
    
    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.isEqual(textBudget){
            UIView.animateWithDuration(1, animations: {
                self.view.transform = CGAffineTransformMakeTranslation(0, -200)
            });
        }
        if textField.isEqual(lableStyle){
            self.view.endEditing(true)
            return false
        }
        return true
    }
    
    //每次编辑完毕都要保存
//    func textFieldDidEndEditing(textField: UITextField) {
//        self.saveToModule()
//    }
    //5月18日评：这个想法简直有病！
    
    
    
    //编辑完成提交数据
    @IBAction func buttonCompeleteTaped() {
        self.view.endEditing(true)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        saveToModule()
        let qos = Int( QOS_CLASS_BACKGROUND.value)
        let queue = dispatch_get_global_queue(qos, 0)
        dispatch_async(queue) {
            sleep(3)
            dispatch_async(dispatch_get_main_queue()) {   //UI相关的动作必须切换到主线程
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.performSegueWithIdentifier("main", sender: nil)
            }
        }
    }
    
    
    @IBOutlet weak var avator: UIButton!
    @IBAction func avatorClicked() {
        let myIPC = UIImagePickerController()
        
        myIPC.sourceType = UIImagePickerControllerSourceType.Camera
        myIPC.delegate = self
        
        //允许调用系统自带的简单编辑
        myIPC.allowsEditing = true
        
        self.presentViewController(myIPC, animated: true, completion: nil)
        
        
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        let image = info["UIImagePickerControllerOriginalImage"] as! UIImage
        avator.setImage(image, forState: UIControlState.Normal)
        
        //头像保存至磁盘
        let phoData =  UIImagePNGRepresentation(image)
        phoData.writeToFile(Url!.path!, atomically: true)
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    
    
    func keyboardHide(){
        self.view.endEditing(true)
    }
    
    
    
}

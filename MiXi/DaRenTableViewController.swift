//
//  DaRenTableViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/28.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class DaRenTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    //这三个是上面的搜索排序拦的三个准备弹出的滑块，两个用storyboard创建，一个用代码创建
    @IBOutlet weak var overAllBar: UIView!
    @IBOutlet weak var priceSearchBar: UIView!
    var distrectBar = UIView(frame: CGRect(x: 0, y: -86, width: 320, height: 186))
    
    //这个方法专门用来初始化distrectBar里面的按钮
    private func initDistrectBar(){
        let dist = ["不限","黄浦区","徐汇区","长宁区",
                    "静安区","闸北区","虹口区","杨浦区",
                    "闵行区","宝山区","嘉定区","浦东新区",
                    "金山区","松江区","青浦区","奉贤区",
                    "崇明县"]
        
        let gapW :CGFloat = 9
        let gapH :CGFloat = 9
        let btnW :CGFloat = (self.distrectBar.frame.width - 5 * gapW) / 4
        let btnH :CGFloat = (self.distrectBar.frame.height - 6 * gapW) / 5
        
        for index in 0..<dist.count{
            let floatIndex = CGFloat(index)
            
            let realX = (floatIndex % 4 + 1) * gapW + floatIndex % 4 * btnW
            let realY = gapH + CGFloat(index / 4) * ( gapH + btnH)
            
            let btn = UIButton()
            btn.frame = CGRectMake(realX, realY, btnW, btnH)
            btn.setTitle(dist[index], forState: UIControlState.Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(12)
            self.distrectBar.addSubview(btn)
            btn.layer.cornerRadius = 4
            btn.layer.borderColor = mixiColor.mainCoffie.CGColor
            btn.layer.borderWidth = 0.5
            btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Normal)
            btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Highlighted)
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
            let buttonImage = UIImage.resizabelImage(name: "按钮－高72")
            btn.setBackgroundImage(buttonImage, forState: UIControlState.Selected)
            btn.addTarget(self, action:Selector("distrectBtnPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        //“不限”默认选中
        let buXian = distrectBar.subviews[0] as? UIButton
        buXian?.selected = true
    }
    
    //区域选择按钮们的点击事件
    func distrectBtnPressed(sender: UIButton){
        if(sender.titleLabel?.text == "不限"){
            for btn in distrectBar.subviews as [UIButton]{
                btn.selected = false
            }
            sender.selected = true
        }else{
            sender.selected = !sender.selected
            let buXian = distrectBar.subviews[0] as? UIButton
            buXian?.selected = false
        }
    }
    
    //三个弹出view的逻辑，用了属性检测
    var priceSearchBarIsOpened :Bool = false{
        willSet{
            if newValue == true{
                UIView.animateWithDuration(0.3, animations: {
                    self.priceSearchBar.transform = CGAffineTransformMakeTranslation(0, self.priceSearchBar.frame.height)
                })
            }else{
                UIView.animateWithDuration(0.3, animations: {
                    self.priceSearchBar.transform = CGAffineTransformMakeTranslation(0, -self.priceSearchBar.frame.height)
                })
            }
        }
    }
    var overAllBarIsOpened :Bool = false{
        willSet{
            if newValue == true{
                UIView.animateWithDuration(0.35, animations: {
                    self.overAllBar.transform = CGAffineTransformMakeTranslation(0, self.overAllBar.frame.height)
                })
            }else{
                UIView.animateWithDuration(0.35, animations: {
                    self.overAllBar.transform = CGAffineTransformMakeTranslation(0, -self.overAllBar.frame.height)
                })
            }
        }
    }
    var distrectBarIsOpened :Bool = false{
        willSet{
            if newValue == true{
                UIView.animateWithDuration(0.4, animations: {
                    self.distrectBar.transform = CGAffineTransformMakeTranslation(0, self.distrectBar.frame.height)
                })
            }else{
                UIView.animateWithDuration(0.4, animations: {
                    self.distrectBar.transform = CGAffineTransformMakeTranslation(0, -self.distrectBar.frame.height)
                })
            }
        }
    }
    
    //搜索bar的点击事件
    @IBAction func btnPriceCliced() {
        priceSearchBarIsOpened = !priceSearchBarIsOpened
        overAllBarIsOpened = false
        distrectBarIsOpened = false
        self.view.endEditing(true)
    }
    @IBAction func btnOverAllClicked() {
        overAllBarIsOpened = !overAllBarIsOpened
        priceSearchBarIsOpened = false
        distrectBarIsOpened = false
        self.view.endEditing(true)
    }
    @IBAction func btnDistrictClicked() {
        distrectBarIsOpened = !distrectBarIsOpened
        overAllBarIsOpened = false
        priceSearchBarIsOpened = false
        self.view.endEditing(true)
    }
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myTableView.delegate = self
        myTableView.dataSource = self
        
        //初始化用代码创建的“地区”滑块
        self.view.addSubview(distrectBar)
        distrectBar.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.view.sendSubviewToBack(distrectBar)
        self.view.sendSubviewToBack(myTableView)
        initDistrectBar()

        
        
        
    }
    

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //push动画切换中的细节
    override func viewWillDisappear(animated: Bool) {
        overAllBar.hidden = true
        priceSearchBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        overAllBar.hidden = false
        priceSearchBar.hidden = false
    }
    
    
//     MARK: - Table view data source
//  优先根据这两个方法的返回值判定有几个cell，用静态单元格的时候注意注释这俩方法
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return 10
    }


    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DaRenCell", forIndexPath: indexPath) as DaRenTableViewCell

        // Configure the cell...

        return cell
    }


    /*
    // Override to support conditional editing of the table view.
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
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
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
    private var distrectBar = UIView(frame: CGRect(x: 0, y: -86, width: 320, height: 186))
    
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
            for btn in distrectBar.subviews as! [UIButton]{
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
                UIView.animateWithDuration(0.4, animations: {
                    self.priceSearchBar.transform = CGAffineTransformMakeTranslation(0, self.priceSearchBar.frame.height)
                })
            }else{
                UIView.animateWithDuration(0.4, animations: {
                    self.priceSearchBar.transform = CGAffineTransformMakeTranslation(0, -self.priceSearchBar.frame.height)
                })
            }
        }
    }
    var overAllBarIsOpened :Bool = false{
        willSet{
            if newValue == true{
                UIView.animateWithDuration(0.55, animations: {
                    self.overAllBar.transform = CGAffineTransformMakeTranslation(0, self.overAllBar.frame.height)
                })
            }else{
                UIView.animateWithDuration(0.55, animations: {
                    self.overAllBar.transform = CGAffineTransformMakeTranslation(0, -self.overAllBar.frame.height)
                })
            }
        }
    }
    var distrectBarIsOpened :Bool = false{
        willSet{
            if newValue == true{
                UIView.animateWithDuration(0.6, animations: {
                    self.distrectBar.transform = CGAffineTransformMakeTranslation(0, self.distrectBar.frame.height)
                })
            }else{
                UIView.animateWithDuration(0.6, animations: {
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
    
    
    @IBOutlet weak var lowToHighBtn: UIButton!
    @IBOutlet weak var highToLowBtn: UIButton!
    @IBOutlet weak var hotSortBtn: UIButton!
    @IBOutlet weak var starSortBtn: UIButton!
    @IBOutlet weak var chekeImageView: UIImageView!
    
    //初始化“综合排序”bar
    private func initOverAllBar(){
        var selectedImageNameSuffix = ["35", "37", "39", "42"]
        var selectedImageName = "蜜喜蜜喜－切片iphone5_"
        var count = 0
        for subView in overAllBar.subviews{
            if let btn = subView as? UIButton{   //筛选按钮进行设置
                btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Normal)
                btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Highlighted)
                btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
                let buttonImage = UIImage.resizabelImage(name: "按钮－高72")
                btn.setBackgroundImage(buttonImage, forState: UIControlState.Selected)
                btn.titleLabel?.font = UIFont.systemFontOfSize(14)
                btn.setImage(UIImage(named: selectedImageName + selectedImageNameSuffix[count]), forState: UIControlState.Selected)
                count++
            }
        }
        sortBtnClicked(lowToHighBtn)
    }
    
    //“综合排序”bar里面的按钮统一用这个点击事件
    @IBAction func sortBtnClicked(sender: UIButton) {
        for subView in overAllBar.subviews{     //遍历overAllBar所有的subview
            if let btn = subView as? UIButton{   //所有按钮设为为选中
                btn.selected = false
            }
        }
        sender.selected = true  //点击的那个选中
        UIView.animateWithDuration(0.2, animations: {[unowned self] in  //注意这里小心循环引用
            self.chekeImageView.center = CGPoint(x: 300, y: sender.center.y)  //这里直接设置center的值比frame方便
        })
    }

   
    
    
    
    
    @IBOutlet weak var myTableView: UITableView!{
        didSet{
            myTableView.delegate = self
            myTableView.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化用代码创建的“地区”滑块
        self.view.addSubview(distrectBar)
        distrectBar.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.view.sendSubviewToBack(distrectBar)
        self.view.sendSubviewToBack(myTableView)
        initDistrectBar()

        initOverAllBar()
        
        
        
    }
    

    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    //push动画切换中的细节
    override func viewWillDisappear(animated: Bool) {
        overAllBar.hidden = true
        priceSearchBar.hidden = true
        self.navigationItem.title = " "
    }
    
    override func viewWillAppear(animated: Bool) {
        overAllBar.hidden = false
        priceSearchBar.hidden = false
        self.navigationItem.title = "摄影"
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
        let cell = tableView.dequeueReusableCellWithIdentifier("DaRenCell", forIndexPath: indexPath) as! DaRenTableViewCell

        // Configure the cell...

        return cell
    }

    
    //这段让上面的bar在滚动时自动收起来
    
    @IBOutlet weak var mainSearchBar: UIView!
    var lastOffSet :CGFloat = 0
    var accumulate :CGFloat = 0  //累计判断正负，以防变化太快

    //监听tableview的滑动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        accumulate += scrollView.contentOffset.y - lastOffSet   //累计混动的距离，向上增加，向下减少
//        println(accumulate)
        if(accumulate > 150){           //150的阈值比较合适
            accumulate = 0
            UIView.animateWithDuration(0.5, animations: {
                self.overAllBar.transform = CGAffineTransformMakeTranslation(0, -self.overAllBar.frame.height - self.mainSearchBar.frame.height)
                self.priceSearchBar.transform = CGAffineTransformMakeTranslation(0, -self.priceSearchBar.frame.height - self.mainSearchBar.frame.height)
                self.mainSearchBar.transform = CGAffineTransformMakeTranslation(0, -self.mainSearchBar.frame.height)
                self.distrectBar.transform = CGAffineTransformMakeTranslation(0, -self.distrectBar.frame.height - self.mainSearchBar.frame.height)
            })
            
            self.view.endEditing(true)
        }else if(accumulate < -10){      //找回来比较容易
            accumulate = 0
            UIView.animateWithDuration(0.5, animations: {
                self.mainSearchBar.transform = CGAffineTransformIdentity
            })
        }
        lastOffSet = scrollView.contentOffset.y
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

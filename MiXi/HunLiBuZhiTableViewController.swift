//
//  HunLiBuZhiTableViewController.swift
//  mixi
//
//  Created by LuRock on 15/3/30.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

//这个controller有80%的代码直接copy的DaRenTableViewController，时间不够以后再重构了

class HunLiBuZhiTableViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{

    //这三个是上面的搜索排序拦的三个准备弹出的滑块，两个用storyboard创建，一个用代码创建
    @IBOutlet weak var overAllBar: UIView!
    @IBOutlet weak var priceSearchBar: UIView!
    var distrectBar = UIView(frame: CGRect(x: 0, y: -86, width: 320, height: 186))
    var filterBar = UIView(frame: CGRect(x: 0, y: -100, width: 320, height: 200))

    //初始化“筛选”bar
    private func initfilterBar(){
        
        let gapGroup :CGFloat = 10
        let gapInner :CGFloat = 7   //按钮上下间距
        let gapHori :CGFloat = 7
        let gapText :CGFloat = 5
        let btnH :CGFloat = 30
        let btnW :CGFloat = (self.view.frame.width - 6 * gapHori) / 5

        let labelH :CGFloat = 12
        
        //创建三个lable
        let siteLable = UILabel(frame: CGRect(x: gapInner, y: 5, width: 25, height: labelH))
        siteLable.text = "场地"
        siteLable.textColor = mixiColor.mainCoffie
        siteLable.font = UIFont.systemFontOfSize(12)
        self.filterBar.addSubview(siteLable)
        
        let styleLable = UILabel(frame: CGRect(x: gapInner, y: siteLable.frame.maxY + gapText + btnH + gapGroup, width: 25, height: labelH))
        styleLable.text = "风格"
        styleLable.textColor = mixiColor.mainCoffie
        styleLable.font = UIFont.systemFontOfSize(12)
        self.filterBar.addSubview(styleLable)
        
        let colorLable = UILabel(frame: CGRect(x: gapInner, y: styleLable.frame.maxY + gapText + 2 * btnH + gapInner + gapGroup, width: 25, height: labelH))
        colorLable.text = "颜色"
        colorLable.textColor = mixiColor.mainCoffie
        colorLable.font = UIFont.systemFontOfSize(12)
        self.filterBar.addSubview(colorLable)
        
        //创建场地的按钮
        let siteName = ["不限","宴会厅","草坪","海边","教堂"]
        let baseY = siteLable.frame.maxY + gapText
        for index in 0..<siteName.count{
            let floatIndex = CGFloat(index)
            
            let realX = (floatIndex % 5 + 1) * gapHori + floatIndex % 5 * btnW
            let realY = CGFloat(index / 5) * ( gapInner + btnH) + baseY
            
            let btn = UIButton()
            btn.frame = CGRectMake(realX, realY, btnW, btnH)
            btn.setTitle(siteName[index], forState: UIControlState.Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(12)
            self.filterBar.addSubview(btn)
            btn.layer.cornerRadius = 4
            btn.layer.borderColor = mixiColor.mainCoffie.CGColor
            btn.layer.borderWidth = 0.5
            btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Normal)
            btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Highlighted)
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
            let buttonImage = UIImage.resizabelImage(name: "按钮－高72")
            btn.setBackgroundImage(buttonImage, forState: UIControlState.Selected)
            
            btn.tag =  100 + index  //用tag分组区分
            btn.addTarget(self, action:Selector("filterBtnPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            if index == 0{
                btn.selected = true
            }
            
        }
        
        //创建风格的按钮
        let styleName = ["不限","梦幻","小清新","奢华","复古","童话","另类","中国风","宫廷风"]
        let baseY2 = styleLable.frame.maxY + gapText
        for index in 0..<styleName.count{
            let floatIndex = CGFloat(index)
            
            let realX = (floatIndex % 5 + 1) * gapHori + floatIndex % 5 * btnW
            let realY = CGFloat(index / 5) * ( gapInner + btnH) + baseY2
            
            let btn = UIButton()
            btn.frame = CGRectMake(realX, realY, btnW, btnH)
            btn.setTitle(styleName[index], forState: UIControlState.Normal)
            btn.titleLabel?.font = UIFont.systemFontOfSize(12)
            self.filterBar.addSubview(btn)
            btn.layer.cornerRadius = 4
            btn.layer.borderColor = mixiColor.mainCoffie.CGColor
            btn.layer.borderWidth = 0.5
            btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Normal)
            btn.setTitleColor(mixiColor.mainCoffie, forState: UIControlState.Highlighted)
            btn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Selected)
            let buttonImage = UIImage.resizabelImage(name: "按钮－高72")
            btn.setBackgroundImage(buttonImage, forState: UIControlState.Selected)
            
            btn.tag = 200 + index  //用tag分组区分
            btn.addTarget(self, action:Selector("filterBtnPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
            
            if index == 0{
                btn.selected = true
            }
        }
        
        //创建颜色的按钮
        
        let baseY3 = colorLable.frame.maxY + gapText
        let colorBtnH :CGFloat = 20
        let colocBtnW :CGFloat = 29
        let gapSmall :CGFloat = (self.view.frame.width - 9 * colocBtnW - 2 * gapInner) / 8
        
        let imageSelectedNameSufix = ["64","65","66","67","68","72","73","74","75"]
        let imageNameSufix = ["80","81","82","83","84","88","86","87","76"]
        let namePrefix = "蜜喜蜜喜－切片iphone5_"
        for index in 0..<imageNameSufix.count{
            let floatIndex = CGFloat(index)
            let realX = gapInner + floatIndex % 9 * (gapSmall + colocBtnW)
            let realY = baseY3
            
            let btn = UIButton()
            btn.frame = CGRectMake(realX, realY, colocBtnW, colorBtnH)
            btn.setTitle(styleName[index], forState: UIControlState.Normal)
            self.filterBar.addSubview(btn)
            
            let buttonImage = UIImage(named: namePrefix + imageNameSufix[index] )
            btn.setBackgroundImage(buttonImage, forState: UIControlState.Normal)

            let buttonSelectedImage = UIImage(named: namePrefix + imageSelectedNameSufix[index])
            btn.setBackgroundImage(buttonSelectedImage, forState: UIControlState.Selected)
            //不要的东西给他干了
            btn.titleLabel?.removeFromSuperview()
            
            btn.tag = 300 + index  //用tag分组区分
            btn.addTarget(self, action:Selector("filterBtnPressed:"), forControlEvents: UIControlEvents.TouchUpInside)
        }
    }
    
    //“场地”按钮们的点击事件
    func filterBtnPressed(sender: UIButton){
        if (sender.tag < 300){    //300以上的颜色不需要排他处理
            if(sender.tag % 100 == 0){              //如果是“不限”点击
                for sub in filterBar.subviews{
                    if let btn = sub as? UIButton{
                        let diff = btn.tag - sender.tag
                        if (diff < 100 && diff > 0){
                            btn.selected = false    //本组全部不选中
                        }
                    }
                }
                sender.selected = true   //“不限”选中
            }else{      //如果是普通按钮点击
                //自己反选
                sender.selected = !sender.selected
                //“不限”取消选中
                let buXianTag = sender.tag / 100 * 100
                for sub in filterBar.subviews{
                    if let btn = sub as? UIButton{
                        if (btn.tag == buXianTag){
                            btn.selected = false
                            break
                        }
                    }
                }
            }
        }else{  //这里是tag300以上的颜色button
            sender.selected = !sender.selected
        }
    }
    
    
    //补充一个
    var filterBarIsOpened :Bool = false{
        willSet{
            if newValue == true{
                UIView.animateWithDuration(0.65, animations: {
                    self.filterBar.transform = CGAffineTransformMakeTranslation(0, self.filterBar.frame.height)
                })
            }else{
                UIView.animateWithDuration(0.65, animations: {
                    self.filterBar.transform = CGAffineTransformMakeTranslation(0, -self.filterBar.frame.height)
                })
            }
        }
    }
    
    @IBAction func btnFilterClicked(sender: UIButton) {
        filterBarIsOpened = !filterBarIsOpened
        overAllBarIsOpened = false
        priceSearchBarIsOpened = false
        distrectBarIsOpened = false
        self.view.endEditing(true)
        
    }
    
    
//------------------------以下全是拷贝的代码-----------------------------------------
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
        filterBarIsOpened = false
        self.view.endEditing(true)
    }
    @IBAction func btnOverAllClicked() {
        overAllBarIsOpened = !overAllBarIsOpened
        priceSearchBarIsOpened = false
        distrectBarIsOpened = false
        filterBarIsOpened = false
        self.view.endEditing(true)
    }
    @IBAction func btnDistrictClicked() {
        distrectBarIsOpened = !distrectBarIsOpened
        overAllBarIsOpened = false
        priceSearchBarIsOpened = false
        filterBarIsOpened = false
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
        //初始化用代码创建的“筛选”滑块
        self.view.addSubview(filterBar)
        filterBar.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1)
        self.view.sendSubviewToBack(filterBar)
        
        
        self.view.sendSubviewToBack(myTableView)
        initDistrectBar()
        
        initOverAllBar()
        
        initfilterBar()
        
        
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
        let cell = tableView.dequeueReusableCellWithIdentifier("HunLiBuZhiCell", forIndexPath: indexPath) as! HunLiBuZhiTableViewCell
        
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
                self.filterBar.transform = CGAffineTransformMakeTranslation(0, -self.filterBar.frame.height - self.mainSearchBar.frame.height)
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
    

}

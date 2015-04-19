//
//  MycellectionViewController.swift
//  mixi
//
//  Created by LuRock on 15/4/19.
//  Copyright (c) 2015年 LuRock. All rights reserved.
//

import UIKit

class MyCollectionViewController: UIViewController, collectionDelegation {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //初始化一个婚礼布置的table
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let hunLiBuZhi = storyBoard.instantiateViewControllerWithIdentifier("BuZhiCollectionTableViewController") as! BuZhiCollectionTableViewController
        self.marrageArrangeViewController = hunLiBuZhi
        hunLiBuZhi.fartherController = self
        
        let daRen = storyBoard.instantiateViewControllerWithIdentifier("DaRenCollectionTableViewController") as! DaRenCollectionTableViewController
        self.daRenArrangeViewController = daRen
        daRen.fartherController = self
        
        daRenIsSelected = true

    }

    //婚礼布置收藏
    var marrageArrangeViewController :BuZhiCollectionTableViewController!
    //达人收藏
    var daRenArrangeViewController :DaRenCollectionTableViewController!
    
    @IBOutlet weak var barImageView: UIImageView!
    @IBOutlet weak var daRenBtn: UIButton!
    @IBOutlet weak var kuLeBtn: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    private var daRenIsSelected:Bool = false{
        didSet{
            self.daRenBtn.selected = daRenIsSelected
            if(daRenIsSelected){
                self.barImageView.image = UIImage(named: "蜜喜蜜喜－切片iphone5_101")

                contentView.insertSubview(self.daRenArrangeViewController.view ,atIndex: 0)
            }else{
                self.daRenArrangeViewController.view.removeFromSuperview()
            }
        }
    }
    
    private var kuLeSelected:Bool = false{
        didSet{
            self.kuLeBtn.selected = kuLeSelected
            if(kuLeSelected){
                self.barImageView.image = UIImage(named: "蜜喜蜜喜－切片iphone5_103")
                contentView.insertSubview(self.marrageArrangeViewController.view,atIndex: 0)

            }else{
                self.marrageArrangeViewController.view.removeFromSuperview()
            }
        }
    }
    
    
    @IBAction func daRenBtnClicked() {
        daRenIsSelected = true
        kuLeSelected = false
    }

    
    
    @IBAction func kuleBtnClicked() {
        daRenIsSelected = false
        kuLeSelected = true
    }
    
    
    //代理方法
    func collectionBtnClicked(){
        performSegueWithIdentifier("myCollection", sender: nil)
        println("collction")
    }
    

}

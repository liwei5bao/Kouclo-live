//
//  KKLHomeViewController.swift
//  Kouclo-live
//
//  Created by liwei on 2016/12/20.
//  Copyright © 2016年 live. All rights reserved.
//  首页主控制器

import UIKit

class KKLHomeViewController: KKLBaseViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    private lazy var datalist:NSArray = {
        let array = ["关注","热门","附近"]
        return array as NSArray
    }()
    
    private lazy var topView:KKLHomeTopView = {
        let top =  KKLHomeTopView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 50), titleNames: self.datalist)
        
        weak var wSelf = self
        top.topBlock = {(tag)in
            
            let scPoint = CGPoint.init(x: CGFloat(tag) * KKLScreenWidth, y: (wSelf?.contentScrollView.contentOffset.y)!)
            wSelf?.contentScrollView.setContentOffset(scPoint,animated: true)
        }
        return top
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
    }

    private func setupUI(){
        self.setupNav()
    }
    
    private func setupNav(){
        self.navigationItem.titleView = topView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "global_search"), style: UIBarButtonItemStyle.done, target: self, action: "")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "title_button_more"), style: UIBarButtonItemStyle.done, target: self, action: "")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

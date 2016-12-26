//
//  KKLHomeViewController.swift
//  Kouclo-live
//
//  Created by liwei on 2016/12/20.
//  Copyright © 2016年 live. All rights reserved.
//  首页主控制器

import UIKit
import SnapKit

class KKLHomeViewController: KKLBaseViewController,UIScrollViewDelegate {
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    private lazy var datalist:NSArray = {
        let array = ["关注","热门","附近"]
        return array as NSArray
    }()
    
    ///导航栏的titleView
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
        self.setupChildVC()
    }
    
    private func setupNav(){
        self.navigationItem.titleView = topView
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "global_search"), style: UIBarButtonItemStyle.done, target: nil, action: nil)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(image: UIImage.init(named: "title_button_more"), style: UIBarButtonItemStyle.done, target: nil, action: nil)
    }
    
    private func setupChildVC(){
        let vcArray = [KKLFocuseViewController(),KKLHotViewController(),KKLNearViewController()]
        for i in 0..<vcArray.count {
            self.addChildViewController(vcArray[i])
        }
        
        self.contentScrollView.contentSize = CGSize.init(width: KKLScreenWidth * CGFloat(vcArray.count), height: 0)
        //展示第二个界面
        self.contentScrollView.contentOffset = CGPoint.init(x: KKLScreenWidth, y: 0)
        self.scrollViewDidEndScrollingAnimation(self.contentScrollView)
    }
    
    //MARK:-UIScrollViewDelegate
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        
        let h = KKLScreenHeight - KKLNavBarHeight - KKLTabbarHeight
        let offset = scrollView.contentOffset.x
        // 获取索引值
        let index = offset / KKLScreenWidth
        //topview联动
        self.topView.scrolling(tag: NSInteger(index))
        //获取当前位置的VC
        let vc = self.childViewControllers[NSInteger(index)]
        //如果已经加载
        if vc.isViewLoaded {return}
        //没加载添加
        scrollView.addSubview(vc.view)
        
        vc.view.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.height.equalTo(h)
            make.left.equalTo(offset)
            make.width.equalTo(scrollView.frame.size.width)
        }
        self.view.layoutIfNeeded()
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.scrollViewDidEndScrollingAnimation(scrollView)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

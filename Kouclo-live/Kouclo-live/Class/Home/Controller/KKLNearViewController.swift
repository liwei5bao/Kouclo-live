//
//  KKLNearViewController.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/24.
//  Copyright © 2016年 live. All rights reserved.
//  首页附近的人控制器

import UIKit

class KKLNearViewController: KKLBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    ///模型数组
    var datalist:NSArray = NSArray()
    
    ///
    private var identifier = "KKLNearLiveCell"
    ///itemW
    private let itemW:CGFloat = 100
    private let itemMargin:CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.loadData()
    }
    
    ///cell将要显示调用
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let c = cell as! KKLNearLiveCell
        c.showAnimation()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return self.datalist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as? KKLNearLiveCell
        cell?.live = self.datalist[indexPath.row] as? KKLLive
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let count:NSInteger = NSInteger(self.collectionView.width / itemW)
        let countF:CGFloat = CGFloat(count)
        let cellW = (self.collectionView.width - itemMargin * (countF + 1))/countF
        return CGSize.init(width: cellW, height: cellW + CGFloat(20))
    }
    
    //初始化控件
    private func setupUI(){
        self.collectionView.register(UINib.init(nibName: "KKLNearLiveCell", bundle: nil), forCellWithReuseIdentifier: identifier)
    }
    
    //初始化数据
    private func loadData(){
    
        KKLHomeHandler.executeGetNearLiveTaskWithSuccess(success: { (result) in
            self.datalist = (result as? NSArray)!
            self.collectionView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }
}

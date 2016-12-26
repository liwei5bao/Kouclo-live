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
    var datalist:NSArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

//
//  KKLHotViewController.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/24.
//  Copyright © 2016年 live. All rights reserved.
//  首页最热控制器

import UIKit

class KKLHotViewController: UITableViewController {
    
    //
    private var identifier = "KKLLiveCell"
    ///模型数组
    var datalist:NSArray = NSArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
        self.loadData()
    }
    
    //MARK:数据源和代理
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datalist.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? KKLLiveCell
        cell?.live = self.datalist[indexPath.row] as? KKLLive
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 70 + KKLScreenWidth
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    //初始化控件
    private func setupUI(){
        
        self.tableView.register(UINib.init(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
        self.tableView.contentInset = UIEdgeInsetsMake(0, 0, KKLTabbarHeight, 0)
    }
    
    //初始化数据
    private func loadData(){
        weak var wSelf = self
        KKLHomeHandler.executeGetHotLiveTaskWithSuccess(success: { (result) in
            
            wSelf?.datalist = result as! NSArray
            wSelf?.tableView.reloadData()
        }) { (error) in
            print(error)
        }
        
    }
    
}

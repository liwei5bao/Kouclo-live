//
//  KKLMyLiveViewController.swift
//  Kouclo-live
//
//  Created by liwei on 2016/12/30.
//  Copyright © 2016年 live. All rights reserved.
//  开启自己的直播

import UIKit
import CoreLocation


class KKLMyLiveViewController: UIViewController {

    @IBOutlet weak var locationBtn: UIButton!
    
    @IBAction func colseBtnClick(_ sender: Any) {
        self.dismiss(animated: true) {}
    }
    
    @IBAction func startLive(_ sender: UIButton) {
        let preView = KKLMyLiveView.init(frame: self.view.bounds)
        preView.vc = self
        self.view.addSubview(preView)
        preView.startLive()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        CLGeocoder().reverseGeocodeLocation(KKLLocationManager.shared().location) { (placemark, error) in
            if (error == nil){
                let pl:CLPlacemark = (placemark?.first)! as CLPlacemark
                self.locationBtn.setTitle(pl.name, for: UIControlState.normal)
                self.locationBtn.sizeToFit()
            }else{
                print("获取地理位置失败")
            }
        }
    }
}

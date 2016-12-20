//
//  KKLBaseNavViewController.swift
//  Kouclo-live
//
//  Created by liwei on 2016/12/20.
//  Copyright © 2016年 live. All rights reserved.
//

import UIKit

class KKLBaseNavViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.barTintColor = UIColor.colorWithRGB(0, g: 216, b: 201)
        self.navigationBar.tintColor = UIColor.white
    }

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
    
        if (self.viewControllers.count > 0) {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: true)
    }
    
}

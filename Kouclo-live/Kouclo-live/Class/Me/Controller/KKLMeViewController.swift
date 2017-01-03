//
//  KKLMeViewController.swift
//  Kouclo-live
//
//  Created by liwei on 2016/12/20.
//  Copyright © 2016年 live. All rights reserved.
//

import UIKit

class KKLMeViewController: KKLBaseViewController {

    @IBAction func loginBtnClick(_ sender: UIButton) {
        
        let vc = KKLLoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        self.title = "我"
    }
    
}

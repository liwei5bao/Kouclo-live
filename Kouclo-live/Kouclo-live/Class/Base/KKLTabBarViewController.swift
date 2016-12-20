//
//  KKLTabBarViewController.swift
//  Kouclo-live
//
//  Created by liwei on 2016/12/20.
//  Copyright © 2016年 live. All rights reserved.
//

import UIKit

class KKLTabBarViewController: UITabBarController {

    //直播按钮
    fileprivate lazy var cameraButton:UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.setImage(UIImage.init(named: "tab_launch"), for: UIControlState.normal)
        btn.addTarget(self, action: #selector(KKLTabBarViewController.cameraButtonClick), for: UIControlEvents.touchUpInside)
        return btn
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.interactivePopGestureRecognizer?.delaysTouchesBegan = false
        //加载控制器
        self.setupViewControllers()
        //删除阴影线
        self.tabBar.shadowImage = UIImage.init()
        self.tabBar.backgroundImage = UIImage.init(named: "global_tab_bg")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        if (cameraButton.superview == nil) {
            self.tabBar.addSubview(cameraButton)
        }
    }
    
    fileprivate func setupViewControllers(){
        let homeVC = KKLHomeViewController()
        let meVC = KKLMeViewController()
        
        self.setupChildViewControllow(homeVC, title: "", image: "tab_live", selectImage: "tab_live_p")
        self.setupChildViewControllow(meVC, title: "", image: "tab_me", selectImage: "tab_me_p")
        
    }
    
    ///添加一个子控制器
    fileprivate func setupChildViewControllow(_ childController:UIViewController,title:String,image:String,selectImage:String){
        
        if self.childViewControllers.count == 0 {
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, -15, -5, 15)
        }else{
            childController.tabBarItem.imageInsets = UIEdgeInsetsMake(5, 15, -5, -15)
        }
        
        childController.tabBarItem.image = UIImage.init(named: image)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        childController.tabBarItem.selectedImage = UIImage.init(named: selectImage)?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let navController = KKLBaseNavViewController(rootViewController: childController)
        self.addChildViewController(navController)
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.cameraButton.sizeToFit()
        self.cameraButton.center = CGPoint.init(x: KKLScreenWidth * 0.5, y: KKLTabbarHeight - 40)
    }
    
    func cameraButtonClick(){
        print("来了")
    }
    
}

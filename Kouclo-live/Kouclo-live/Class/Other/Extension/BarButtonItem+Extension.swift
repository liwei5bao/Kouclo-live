//
//  BarButtonItem+Extension.swift
//  KoucloTown
//
//  Created by kouclo on 16/8/10.
//  Copyright © 2016年 liwei. All rights reserved.
//  导航栏item的拓展

import UIKit
extension UIBarButtonItem{
    ///创建左边的item
    class func barButtonLeftItemWithImageName(_ imageName:String,target:AnyObject?,action:Selector)->UIBarButtonItem{
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 30, height: 22))
        button.setImage(UIImage.init(named: imageName), for: UIControlState())
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 8)
        let barButtonItem = UIBarButtonItem.init(customView: button)
        return barButtonItem
    }
    ///创建右边的item
    class func barButtonRightItemWithImageName(_ imageName:String,target:AnyObject?,action:Selector)->UIBarButtonItem{
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 22))
        button.setImage(UIImage.init(named: imageName), for: UIControlState())
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 28, 0, 0)
        let barButtonItem = UIBarButtonItem.init(customView: button)
        return barButtonItem
    }
    ///创建自定义的item
    class func barButtonItemWithImageName(_ imageName:String,target:AnyObject?,action:Selector,imageEdgeInsets:UIEdgeInsets)->UIBarButtonItem{
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 22))
        button.setImage(UIImage.init(named: imageName), for: UIControlState())
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        button.imageEdgeInsets = imageEdgeInsets
        let barButtonItem = UIBarButtonItem.init(customView: button)
        return barButtonItem
    }
    ///创建文字形式的item
    class func barButtonItemWithTitle(_ title:String,selectTitle:String,target:AnyObject?,action:Selector)->UIBarButtonItem{
        let button = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 50, height: 22))
        button.setTitle(title, for: UIControlState())
        button.setTitle(selectTitle, for: UIControlState.selected)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.addTarget(target, action: action, for: UIControlEvents.touchUpInside)
        let barButtonItem = UIBarButtonItem.init(customView: button)
        return barButtonItem
     }
}

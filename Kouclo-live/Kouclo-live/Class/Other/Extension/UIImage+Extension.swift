//
//  UIImage+Extension.swift
//  KoucloTown
//
//  Created by liwei on 16/9/12.
//  Copyright © 2016年 kouclo. All rights reserved.
//  图片的分类

import UIKit

///颜色转换为图片
extension UIImage{
    

    
    ///创建一个颜色图片
    class func imageWithColor(_ color:UIColor)-> UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(color.cgColor)
        context?.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}


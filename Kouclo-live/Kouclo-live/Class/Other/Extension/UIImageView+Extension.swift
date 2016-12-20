//
//  UIImageView+Extension.swift
//  KoucloTown
//
//  Created by kouclo on 16/8/10.
//  Copyright © 2016年 liwei. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage
extension UIButton{
    //加载圆形头像
    func setHeaderWithURL(_ urlStr:String) {
        let url = URL.init(string: urlStr)
        self.sd_setImage(with: url, for: UIControlState.normal) { (image, error, imageCacheType, url) in
            self.setImage(image?.circleImage(), for: UIControlState.normal)
        }
    }
}

extension UIImageView{
    //加载圆形头像
    func setHeaderWithURL(_ urlStr:String) {
        let url = URL.init(string: urlStr)
        
        self.sd_setImage(with: url) { (image, error, imageCacheType, url) in
            self.image = image!.circleImage()

        }
    }
}

extension UIImage{
    
    func circleImage() -> UIImage {
        
        //1.开启图形上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        //2.获取图形上下文
        let ctx = UIGraphicsGetCurrentContext()
        //3.添加一个圆
        let rect = CGRect.init(x: 0, y: 0, width: self.size.width, height: self.size.height)
        ctx?.addEllipse(in: rect)
        //4.裁剪
        ctx?.clip()
        //5.画图
        self.draw(in: rect)
        //6.取出图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //7.关闭上下文
        UIGraphicsEndImageContext()
        return image!
    }
}

//
//  UIImageView+SDWebImage.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/25.
//  Copyright © 2016年 live. All rights reserved.
//  SD封装

import UIKit
import SDWebImage

typealias DownloadImageSuccessBlock = (_ image:UIImage)->()
typealias DownloadImageFailedBlock = (_ error:NSError)->()
typealias DownloadImageProgressBlock = (_ progress:CGFloat)->()

extension UIImageView {

    /**
     *  异步加载图片
     *
     *  @param url       图片地址
     *  @param imageName 占位图片名
     */
    func downloadImage(url:String,placeholderImageName:String){
        
        self.sd_setImage(with: NSURL.init(string: url) as URL!, placeholderImage: UIImage.init(named: placeholderImageName), options: [SDWebImageOptions.retryFailed,SDWebImageOptions.lowPriority,SDWebImageOptions.progressiveDownload])
    }
    
    /**
     *  异步加载图片，可以监听下载进度，成功或失败
     *
     *  @param url       图片地址
     *  @param imageName 占位图片名
     *  @param success   下载成功
     *  @param failed    下载失败
     *  @param progress  下载进度
     */
    func downloadImage(url:String,placeholderImageName:String,success:@escaping DownloadImageSuccessBlock,failed:@escaping DownloadImageFailedBlock,progress:@escaping DownloadImageProgressBlock){
        
        self.sd_setImage(with: NSURL.init(string: url) as URL!, placeholderImage: UIImage.init(named: placeholderImageName), options: [SDWebImageOptions.retryFailed,SDWebImageOptions.lowPriority,SDWebImageOptions.progressiveDownload], progress: { (receivedSize, expectedSize) in
            
                progress(CGFloat(receivedSize / expectedSize))
            
            }) { (image, error, cacheType, imageURL) in

                if(error != nil){
                    failed(error as! NSError)
                }else{
                    self.image = image
                    success(image!)
                }
        }
        
    }
}

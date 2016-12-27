//
//  KKLHomeHandler.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/25.
//  Copyright © 2016年 live. All rights reserved.
//  获取首页数据

import UIKit

typealias CompleteBlock = ()->()
typealias SuccessBlock = (_ json:Any)->()
typealias FailedBlock = (_ json:Any)->()

class KKLHomeHandler: NSObject {

    ///获取附近的直播
    class func executeGetNearLiveTaskWithSuccess(success:@escaping SuccessBlock,failure:@escaping FailedBlock){
        
        let params = ["uid":"85149891","latitude":"40.090562","longitude":"116.413353"]
    
        HttpTool.getWithPath(path: API_NearLive, params: params as NSDictionary, success: { (json) in
            let result = json as! NSDictionary
            if((result["dm_error"] as? NSInteger) != 0){
                
                failure(json)
                
            }else{
                
                let lives = KKLLive.mj_objectArray(withKeyValuesArray: result["lives"])
                if let lives = lives{
                    success(lives)
                }else{
                    failure(NSError())
                }
                
            }
            
            }) { (error) in
                
                failure(error)
        }
        
    }
    
}

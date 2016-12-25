//
//  HttpTool.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/25.
//  Copyright © 2016年 live. All rights reserved.
//  AF封装

import UIKit
import AFNetworking

typealias HttpSuccessBlock = (_ json:Any)->()
typealias HttpFailureBlock = (_ error:NSError)->()
typealias HttpDownloadProgressBlock = (_ progress:CGFloat)->()
typealias HttpUploadProgressBlock = (_ progress:CGFloat)->()

class HttpTool: NSObject {
    
    /**
     *  get网络请求
     *
     *  @param path    url地址
     *  @param params  url参数  NSDictionary类型
     *  @param success 请求成功 返回NSDictionary或NSArray
     *  @param failure 请求失败 返回NSError
     */
    class func getWithPath(path:String,params:NSDictionary,success:@escaping HttpSuccessBlock,failure:@escaping HttpFailureBlock) {
        
        let allUrl = SERVER_HOST + "/" + path
        
        AFHttpClient.sharedClient.get(allUrl, parameters: params, progress: nil, success: { (task, responseObject) in
                success(responseObject)
            }) { (task, error) in
                failure(error as NSError)
        }
        
    }
    
    /**
     *  post网络请求
     *
     *  @param path    url地址
     *  @param params  url参数  NSDictionary类型
     *  @param success 请求成功 返回NSDictionary或NSArray
     *  @param failure 请求失败 返回NSError
     */
    class func postWithPath(path:String,params:NSDictionary,success:@escaping HttpSuccessBlock,failure:@escaping HttpFailureBlock) {
        
        let allUrl = SERVER_HOST + "/" + path
        AFHttpClient.sharedClient.post(allUrl, parameters: params, progress: nil, success: { (task, responseObject) in
            success(responseObject)
        }) { (task, error) in
            failure(error as NSError)
        }
        
    }
    
}


class AFHttpClient:AFHTTPSessionManager{
    //创建单例
    private static let httpClient = AFHttpClient.init(baseURL: NSURL.init(string: SERVER_HOST) as URL?, sessionConfiguration: URLSessionConfiguration.default)
    class var sharedClient:AFHttpClient {
        
        httpClient.responseSerializer.acceptableContentTypes = NSSet.init(array: ["application/json","text/html", "text/json", "text/javascript","text/plain","image/gif"]) as? Set<String>
        httpClient.requestSerializer.timeoutInterval = 10
        httpClient.securityPolicy = AFSecurityPolicy.default()
    
        return httpClient
    }

}

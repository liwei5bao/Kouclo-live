//
//  KKLLive.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/25.
//  Copyright © 2016年 live. All rights reserved.
//  热门直播模型

import UIKit

class KKLLive: NSObject {

    var city : String?
    var creator : KKLCreator?
    var group : Int?
    var id : String?
    var image : String?
    var link : Int?
    var multi : Int?
    var name : String?
    var onlineUsers : Int?
    var optimal : Int?
    var pubStat : Int?
    var roomId : Int?
    var rotate : Int?
    var shareAddr : String?
    var slot : Int?
    var status : Int?
    var streamAddr : String?
    var version : Int?
    
    var distance : String?
    
    ///是否已经加载过了
    var isShow : Bool = false
}

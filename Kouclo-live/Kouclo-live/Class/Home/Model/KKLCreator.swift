//
//  KKLCreator.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/25.
//  Copyright © 2016年 live. All rights reserved.
//  主播个人资料模型

import UIKit

class KKLCreator: NSObject {
    
    var birth : String?
    var description_field : String?
    var emotion : String?
    var gender : NSNumber?
    var gmutex : NSNumber?
    var hometown : String?
    var ID : NSNumber?
    var inke_verify : NSNumber?
    var level : NSNumber?
    var location : String?
    var nick : String?
    var portrait : String?
    var profession : String?
    var rank_veri : NSNumber?
    var sex : NSNumber?
    var third_platform : String?
    var veri_info : String?
    var verified : NSNumber?
    var verified_reason : String?
    
    override static func mj_replacedKeyFromPropertyName() -> [AnyHashable : Any]! {
        return ["ID":"id"]
    }
}

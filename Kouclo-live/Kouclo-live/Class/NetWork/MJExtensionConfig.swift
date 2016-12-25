//
//  MJExtensionConfig.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/25.
//  Copyright © 2016年 live. All rights reserved.
//  配置将要转换的模型数据

import UIKit
import MJExtension

class MJExtensionConfig: NSObject {

    override class func initialize(){
        NSObject.mj_setupReplacedKey { () -> [AnyHashable : Any]? in
            return ["ID":"id"]
        }
        
        //驼峰转下划线
        KKLLive.mj_setupReplacedKey { (propertyName) -> Any? in
            return propertyName?.mj_underlineFromCamel
        }

        KKLCreator.mj_setupReplacedKey { (propertyName) -> Any? in
            return propertyName?.mj_underlineFromCamel
        }
    }
    
}

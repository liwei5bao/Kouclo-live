//
//  UserUtil.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/24.
//  Copyright © 2016年 live. All rights reserved.
//

import UIKit
import MJExtension
class UserUtil: NSObject {
    
    ///保存用户信息
    class func saveUserModel(_ userM:UserModel) {
        let dic = userM.mj_keyValues()
        let data = NSKeyedArchiver.archivedData(withRootObject: dic! as NSDictionary)
        let defaults = UserDefaults.standard
        defaults.set(data, forKey: "UserModel")
        defaults.synchronize()
    }
    
    ///取出用户的信息
    class func getUserModel()->UserModel?{
        var model:UserModel?
        let defaults = UserDefaults.standard
        let data = defaults.object(forKey: "UserModel") as? Data
        if (data != nil) {
            let dic = NSKeyedUnarchiver.unarchiveObject(with: data!) as? NSDictionary
            model = UserModel.mj_object(withKeyValues: dic)
            if (model != nil) {
                return model!
            }else{
                return nil
            }
        }else{
            return nil
        }
    }
    
    ///退出登录
    class func delUserModel() {
        let defaults = UserDefaults.standard
        defaults.set(nil, forKey: "UserModel")
        defaults.synchronize()
    }
    
    ///判断是否登录
    class func isUserLogin()->Bool{
        if (self.getUserModel() != nil) {
            return true
        }else{
            return false
        }
    }
}

class UserModel: NSObject {

    ///token
    var token:String?
    ///账号
    var user_name:String?
    ///用户id
    var user_id:NSNumber?
    ///用户密码
    var user_psd:String?
    ///支付id
    var payer_id:NSNumber?
    ///电话号
    var telephone:String?
    ///性别
    var sex:String?
    ///生日
    var birthday:String?
    ///邮箱
    var email:String?
    ///昵称
    var nick_name:String?
    ///头像
    var photo:String?
    ///真实姓名
    var real_name:String?

    //经度
    var lat:String?
    //维度
    var lon:String?
    
}

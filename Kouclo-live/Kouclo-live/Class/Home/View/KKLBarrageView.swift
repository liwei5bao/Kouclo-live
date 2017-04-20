//
//  KKLBarrageView.swift
//  Kouclo-live
//
//  Created by liwei on 17/4/15.
//  Copyright © 2017年 live. All rights reserved.
//

import UIKit
import YYKit
enum BarrageType {
    case Start
    case FullAccess
    case End
}

typealias KKLBarrageLableTypeBlock = (_ barrageT:BarrageType,_ lable:UILabel)->()

class KKLBarrageView: UIView {
    var timer:Timer?
    ///后台弹幕数据
    var barrageStrArray:NSMutableArray = NSMutableArray()
    
    /// 控制是否需要timer循环检测调用加载动画
    var isUseTimeAddAnimate:Bool = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup(){
        //添加数据
        self.dataSouse()
        timer = Timer.scheduledTimer(timeInterval: 1, target: YYWeakProxy.init(target: self), selector: #selector(KKLBarrageView.barrageLableAnimate), userInfo: nil, repeats: true)
    }
    
    //添加到view上边一个弹幕
    func barrageLableAnimate(){
        //调用动画
        if(isUseTimeAddAnimate){
            self.showBarrageLableAnimate()
        }
    }

    private func showBarrageLableAnimate(){
        weak var wSelf = self
        //如果数据为空让timer循环检测 否则关闭检测
        isUseTimeAddAnimate = false
        if (barrageStrArray.count == 0) {
            isUseTimeAddAnimate = true
            
            ///模拟添加数据不让弹幕终止  此处应该是网络请求回来添加的数据
            self.dataSouse()
            return
        }
        
        if let firstStr = barrageStrArray.object(at: 0) as? String{
            barrageStrArray.removeObject(at: 0)
            self.createLable(contentStr: firstStr) { (type,lable) in
                switch type{
                case .FullAccess://完全进入
                    //主线程更新UI 若不在主线UI控件不在屏幕上渲染
                    DispatchQueue.main.async {
                        wSelf?.showBarrageLableAnimate()
                    }
                case .End://结束
                    lable.removeFromSuperview()
                default:
                    break
                }
            }
        }
    }
    
    
    private func dataSouse(){
        self.barrageStrArray.addObjects(from: souseArray)
    }
    
    //创建lable
    private func createLable(contentStr:String,type:@escaping KKLBarrageLableTypeBlock){
        let lableH:CGFloat = 30
        let barrageLable = UILabel.init()
        self.addSubview(barrageLable)
        barrageLable.text = contentStr
        barrageLable.textColor = UIColor.purple
        barrageLable.font = UIFont.systemFont(ofSize: 14)
        let barrageSize = contentStr.size(attributes:[NSFontAttributeName : UIFont.systemFont(ofSize: 14)])
        barrageLable.size = CGSize.init(width: barrageSize.width + 20, height: lableH)
        
        //计算运动总长度
        let moveW = barrageLable.width + KKLScreenWidth
        let moveT:CGFloat = 8
        let moveV = moveW / moveT
        let fullAccessTime:CGFloat = barrageLable.width / moveV
        
        //创建三个轨迹 随机出现轨迹
        let trajectoryIndex:Int = Int(arc4random()%3)
        barrageLable.top = CGFloat(trajectoryIndex) * lableH
        barrageLable.left = KKLScreenWidth
        
        //执行回调
        let delayFullAccessTime:DispatchTimeInterval = .seconds(Int(fullAccessTime))
        let delayEndTime:DispatchTimeInterval = .seconds(Int(moveT))
        let delayQueue = DispatchQueue.init(label: "com.syc.nd", qos: DispatchQoS.userInteractive)
        //完全进入后
        delayQueue.asyncAfter(deadline:.now() + delayFullAccessTime) {
            type(BarrageType.FullAccess,barrageLable)
        }
        //结束
        delayQueue.asyncAfter(deadline:.now() + delayEndTime) {
            type(BarrageType.End,barrageLable)
        }
        
        UIView.animate(withDuration: TimeInterval(moveT)) {
            barrageLable.left = -barrageLable.width
        }
        
    }

    private let souseArray:[String] = ["主播你好靓啊~~~~~( ⊙ o ⊙ )啊！","主播唱首歌吧你唱歌好听吗","主播怎么不说话~~~","没意思~~~","主播你好靓啊~~~~~( ⊙ o ⊙ )啊！","主播唱首歌吧你唱歌好听吗","主播怎么不说话~~~","没意思~~~","主播你好靓啊~~~~~( ⊙ o ⊙ )啊！","主播唱首歌吧你唱歌好听吗","主播怎么不说话~~~","没意思~~~","主播你好靓啊~~~~~( ⊙ o ⊙ )啊！","主播唱首歌吧你唱歌好听吗","主播怎么不说话~~~","没意思~~~"]
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

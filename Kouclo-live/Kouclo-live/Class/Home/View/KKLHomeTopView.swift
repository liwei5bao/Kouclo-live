//
//  KKLHomeTopView.swift
//  Kouclo-live
//
//  Created by liwei on 16/12/24.
//  Copyright © 2016年 live. All rights reserved.
//  首页导航栏顶部的View

import UIKit

typealias Completion = (_ result: AnyObject?, _ error: NSError?) -> ()
typealias Result = (_ result:AnyObject?,_ code:String?) -> ()
typealias HomeTopViewBlock = (_ tag:NSInteger)->()

class KKLHomeTopView: UIView {

    var topBlock:HomeTopViewBlock?
    
    var buttons:NSMutableArray = {
        let btns = NSMutableArray()
        return btns
    }()
    
    private var lineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        return view
    }()
    
    convenience init(frame: CGRect,titleNames:NSArray) {
        self.init(frame: frame)
        let btnW = self.width / CGFloat(titleNames.count)
        let btnH = self.height
        for i in 0..<titleNames.count {
            let btn = UIButton.init(type: UIButtonType.custom)
            self.buttons.add(btn)
            
            let vcName = titleNames[i] as! String
            btn.setTitle(vcName, for: UIControlState.normal)
            btn.setTitleColor(UIColor.white, for: UIControlState.normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 18)
            
            btn.tag = i
            btn.frame = CGRect.init(x: btnW * CGFloat(i), y: 0, width: btnW, height: btnH)
        
            self.addSubview(btn)
            btn.addTarget(self, action:  #selector(KKLHomeTopView.titleClick(btn:)), for: UIControlEvents.touchUpInside)
            if(i == 1 ){
                let y:CGFloat = 40
                let h:CGFloat = 2
                btn.titleLabel?.sizeToFit()
                
                self.lineView.height = h
                self.lineView.top = y
                self.lineView.width = (btn.titleLabel?.width)!
                self.lineView.centerX = btn.centerX
                
                self.addSubview(lineView)
            }
            
        }
        
    }
    
    func titleClick(btn:UIButton){
        if let topBlock = topBlock{
            topBlock(btn.tag)
        }
        
        self.scrolling(tag: btn.tag)
    }
    
    ///首页主控制器滚动时调用
    func scrolling(tag:NSInteger){
        let btn = buttons[tag] as! UIButton
        UIView.animate(withDuration: 0.5) { 
            self.lineView.centerX = btn.centerX
        }
    }
    

}

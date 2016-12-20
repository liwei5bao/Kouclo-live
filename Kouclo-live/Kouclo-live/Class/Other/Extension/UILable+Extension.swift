//
//  UILable+Extension.swift
//  KoucloTown
//
//  Created by kouclo on 16/8/10.
//  Copyright © 2016年 liwei. All rights reserved.
//

import UIKit

extension UILabel{
    
    //快速初始化一个lable
    class func lableWithFont(_ font:CGFloat,textColor:UIColor,numberOfLine:NSInteger)->UILabel{
        let lable = UILabel()
        lable.font = UIFont.systemFont(ofSize: font)
        lable.textColor = textColor
        lable.numberOfLines = numberOfLine
        return lable
    }
    
    //设置lable的行间距
    func setLableSpacing(_ spacing:CGFloat,content:String?) {
        if (content == nil) {
            return
        }
        let attStr = NSMutableAttributedString.init(string: content!)
        let style = NSMutableParagraphStyle.init()
        attStr.addAttribute(NSParagraphStyleAttributeName, value: style, range: NSRange.init(location: 0, length: (content?.characters.count)!))
        self.attributedText = attStr
    }
    
    //获取label的高度
    func getLabelHeightWithMaxWidth(_ width:CGFloat)-> CGFloat{
        return self.systemLayoutSizeFitting(CGSize.init(width: width, height: CGFloat(MAXFLOAT))).height
    }
    
    //获取一段文字的行数
    func getNumOfLineWithContent(_ content:String,width:CGFloat) -> NSInteger {
        self.preferredMaxLayoutWidth = width
        let rect = (content as NSString).boundingRect(with: CGSize.init(width: width, height: CGFloat(MAXFLOAT)), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSFontAttributeName:self.font], context: nil)
        let linCount = (NSInteger)(rect.size.height / self.font.lineHeight)
        return linCount
    }
}

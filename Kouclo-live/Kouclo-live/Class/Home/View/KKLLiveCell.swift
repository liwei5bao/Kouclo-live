//
//  KKLLiveCell.swift
//  Kouclo-live
//
//  Created by liwei on 2016/12/27.
//  Copyright © 2016年 live. All rights reserved.
//

import UIKit

class KKLLiveCell: UITableViewCell {
    
    @IBOutlet weak var headView: UIImageView!
    
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var onLineLabel: UILabel!
    @IBOutlet weak var bigImageView: UIImageView!
    
    
    var live:KKLLive?{
        didSet{
            self.nameLable.text = live?.creator?.nick
            self.locationLabel.text = live?.city
            if let users = live?.online_users{
                self.onLineLabel.text = "\(users)"
            }else{
                self.onLineLabel.text = "0"
            }
            
            if live?.creator?.nick == "MySelf"{
                self.headView.image = UIImage.init(named: "akaliCosplay")
                self.bigImageView.image = UIImage.init(named: "akaliCosplay")
            }else{
                let imageUrl = IMAGE_HOST + (live?.creator?.portrait)!
                self.headView.downloadImage(url: imageUrl, placeholderImageName: KKLPlaceholderImageName)
                self.bigImageView.downloadImage(url: imageUrl, placeholderImageName: KKLPlaceholderImageName)
            }
        
        }
    }
 
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

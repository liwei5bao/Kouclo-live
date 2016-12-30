//
//  KKLMyLiveView.swift
//  Kouclo-live
//
//  Created by liwei on 2016/12/30.
//  Copyright © 2016年 live. All rights reserved.
//  自己直播的界面

import UIKit
import LFLiveKit
import YYKit

class KKLMyLiveView: UIView,LFLiveSessionDelegate {
    
    var vc:UIViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
        self.initUI()
        self.dealEvent()
    }
    
    private func setup(){
        session.delegate = self
        session.showDebugInfo = false
        session.preView = self
        self.requestAccessForAudio()
        self.requestAccessForVideo()
    }
    
    private func initUI(){
        self.addSubview(containerView)
        self.containerView.addSubview(stateLabel)
        self.containerView.addSubview(closeButton)
        self.containerView.addSubview(cameraButton)
        self.containerView.addSubview(beautyBtn)
    }
    
    private func requestAccessForVideo(){
        weak var wself = self
        let status:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeVideo)
        switch status {
        case AVAuthorizationStatus.notDetermined:
            // 许可对话没有出现，发起授权许可
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeVideo, completionHandler: { (granted) in
                if granted{
                    dispatch_async_on_main_queue({ 
                        wself?.session.running = true
                    })
                }
            })
            break
        case AVAuthorizationStatus.authorized:
            dispatch_async_on_main_queue({ 
                wself?.session.running = true
            })
            break
        case AVAuthorizationStatus.restricted:
            // 用户明确地拒绝授权，或者相机设备无法访问
            break
        default:
            break
        }
    }
    
    private func requestAccessForAudio(){
        weak var wself = self
        let status:AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(forMediaType: AVMediaTypeAudio)
        switch status {
        case AVAuthorizationStatus.notDetermined:
            // 许可对话没有出现，发起授权许可
            AVCaptureDevice.requestAccess(forMediaType: AVMediaTypeAudio, completionHandler: { (granted) in
                if granted{
                    dispatch_async_on_main_queue({
                        wself?.session.running = true
                    })
                }
            })
            break
        default:
            break
        }
    }

    
    private func dealEvent(){
        
        weak var wself = self
        
        closeButton.addBlock(for: UIControlEvents.touchUpInside) { (sender) in
            wself?.stopLive()
            wself?.vc?.dismiss(animated: true, completion: {})
        }
        
        cameraButton.origin = CGPoint.init(x: closeButton.left - 10 - cameraButton.width, y: 20)
        cameraButton.addBlock(for: UIControlEvents.touchUpInside) { (sender) in
            //切换前后摄像头的方法
            let devicePositon:AVCaptureDevicePosition = (wself?.session.captureDevicePosition)!
            wself?.session.captureDevicePosition = (devicePositon == AVCaptureDevicePosition.back) ? AVCaptureDevicePosition.front : AVCaptureDevicePosition.back
        }
        
        beautyBtn.origin = CGPoint.init(x: cameraButton.left - 10 - cameraButton.width, y: 20)
        beautyBtn.addBlock(for: UIControlEvents.touchUpInside) { (sender) in
            if let beautyFace = wself?.session.beautyFace{
                wself?.session.beautyFace = !beautyFace
                wself?.beautyBtn.isSelected = !beautyFace
            }
        }
    }
    
    //MARK:开启直播
    func startLive(){
        let stream:LFLiveStreamInfo = LFLiveStreamInfo()
        stream.url = Live_KoucloLive
        session.startLive(stream)
    }
    
    //MARK:关闭直播
    func stopLive() {
        session.stopLive()
    }
    
    
    //MARK: LFStreamingSessionDelegate
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        switch state {
        case LFLiveState.ready:
            stateLabel.text = "未连接"
            break
        case LFLiveState.pending:
            stateLabel.text = "连接中"
            break
        case LFLiveState.start:
            stateLabel.text = "已连接"
            break
        case LFLiveState.error:
            stateLabel.text = "连接错误"
            break
        case LFLiveState.stop:
            stateLabel.text = "已断开"
            break
        default:
            break
        }
    }
    
    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print(errorCode)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    ///底层的view
    var containerView:UIView = {
        let view = UIView()
        view.frame = KKLScreenBounds
        view.backgroundColor = UIColor.clear
        view.autoresizingMask = [UIViewAutoresizing.flexibleWidth,UIViewAutoresizing.flexibleHeight]
        return view
    }()
    
    ///连接状态
    var stateLabel:UILabel = {
        let lable = UILabel.init(frame: CGRect.init(x: 20, y: 20, width: 80, height: 40))
        lable.text = "未连接"
        lable.textColor = UIColor.white
        lable.font = UIFont.systemFont(ofSize: 14)
        return lable
    }()
    
    /// 关闭按钮
    var closeButton:UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.size = CGSize.init(width: 44, height: 44)
        btn.left = KKLScreenWidth - 10 - btn.width
        btn.top = 20
        btn.setImage(UIImage.init(named: "close_preview"), for: UIControlState.normal)
        return btn
    }()
    
    /// 切换摄像头
    var cameraButton:UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.size = CGSize.init(width: 44, height: 44)
        btn.setImage(UIImage.init(named: "camra_preview"), for: UIControlState.normal)
        return btn
    }()
    
    /// 美颜按钮
    var beautyBtn:UIButton = {
        let btn = UIButton.init(type: UIButtonType.custom)
        btn.size = CGSize.init(width: 44, height: 44)
        btn.setImage(UIImage.init(named: "camra_beauty"), for: UIControlState.normal)
        btn.setImage(UIImage.init(named: "camra_beauty_close"), for: UIControlState.selected)
        return btn
    }()
    
    /// 直播会话状态
    var session:LFLiveSession = {
        /***   默认分辨率368 ＊ 640  音频：44.1 iphone6以上48  双声道  方向竖屏 ***/
        let _session:LFLiveSession = LFLiveSession.init(audioConfiguration: LFLiveAudioConfiguration.default(), videoConfiguration: LFLiveVideoConfiguration.default())!
    
//        let audioConfiguration = LFLiveAudioConfiguration()
//        audioConfiguration.numberOfChannels = 2
//        audioConfiguration.audioBitrate = LFLiveAudioBitRate._128Kbps
//        audioConfiguration.audioSampleRate = LFLiveAudioSampleRate._48000Hz
        
        return _session
    }()
}

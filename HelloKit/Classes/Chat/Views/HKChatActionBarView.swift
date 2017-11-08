//
//  HKChatActionBarView.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/1.
//  Copyright © 2017年 Weelh. All rights reserved.
//

/*! 发送信息操作栏 */

import UIKit

let kChatActionBarOriginalHeight: CGFloat = 50.0
let kChatActionBarTextViewMaxHeight: CGFloat = 120.0

// 协议后面跟class关键字表明这个协议只能用在类上
protocol HKChatActionBarViewDelegate: class {
    
    /*! 点击切换录音按钮.隐藏键盘 */
    func chatActionBarRecordVoiceHideKeyboard()
    
    /*! 显示表情键盘,并且处理键盘高度 */
    func chatActionBarShowEmotionKeyboard()
    
    /*! 显示分享键盘,并且处理键盘高度 */
    func chatActionBarShowShareKeyboard()
}


class HKChatActionBarView: UIView {

    enum ChatKeyboardType: Int {
        case `default`, text, emotion, share
    }
    
    var keyboardType: ChatKeyboardType = .default
    weak var delegate: HKChatActionBarViewDelegate?
    var inputTextViewCurrentHeight: CGFloat = kChatActionBarOriginalHeight
    
    // 语音文字切换按钮
    @IBOutlet weak var voiceButton: HKChatButton!
    // +号按钮
    @IBOutlet weak var shareButton: HKChatButton! {
        didSet {
            shareButton.showTypingKeyboard = false
        }
    }
    // 表情按钮
    @IBOutlet weak var emotionButton: HKChatButton! {
        didSet {
            shareButton.showTypingKeyboard = false
        }
    }
    // 按住说话按钮
    @IBOutlet weak var recordButton: UIButton! {
        didSet {
            recordButton.setBackgroundImage(UIImage.ts_imageWithColor(UIColor.init(ts_hexString: "#F3F4F8")), for: .normal)
            recordButton.setBackgroundImage(UIImage.ts_imageWithColor(UIColor.init(ts_hexString: "#C6C7CB")), for: .highlighted)
            recordButton.layer.borderColor = UIColor.init(ts_hexString: "#C2C3C7").cgColor
            recordButton.layer.borderWidth = 0.5
            recordButton.layer.cornerRadius = 5.0
            recordButton.layer.masksToBounds = true
            recordButton.isHidden = true
        }
    }
    // 文字输入框
    @IBOutlet weak var inputTextView: UITextView! {
        didSet {
            inputTextView.font = UIFont.systemFont(ofSize: 17)
            inputTextView.layer.borderColor = UIColor.init(ts_hexString: "#DADADA").cgColor
            inputTextView.layer.borderWidth = 1.0
            inputTextView.layer.cornerRadius = 5.0
            inputTextView.scrollsToTop = false
            inputTextView.textContainerInset = UIEdgeInsetsMake(7, 5, 5, 5)
            inputTextView.backgroundColor = UIColor.init(ts_hexString: "#f8fefb")
            inputTextView.returnKeyType = .send
            inputTextView.isHidden = false
            inputTextView.enablesReturnKeyAutomatically = true //输入框有值的时候才能点击returnKey
            inputTextView.layoutManager.allowsNonContiguousLayout = false //解决UITextView输入文字的时候自动滚动到顶部
            inputTextView.scrollsToTop = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initContent()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
        self.initContent()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initContent()
    }
    
    deinit {
        log.verbose("deinit")
    }
    
    func initContent() {
        let topBorder = UIView()
        let bottomBorder = UIView()
        topBorder.backgroundColor = UIColor.init(ts_hexString: "#C2C3C7")
        bottomBorder.backgroundColor = UIColor.init(ts_hexString: "#C2C3C7")
        self.addSubview(topBorder)
        self.addSubview(bottomBorder)
        
        topBorder.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self)
            make.height.equalTo(0.5)
        }
        bottomBorder.snp.makeConstraints { (make) in
            make.bottom.left.right.equalTo(self)
            make.height.equalTo(0.5)
        }
    }
}


// MARK: - 控制键盘互斥事件
extension HKChatActionBarView {
    
}



















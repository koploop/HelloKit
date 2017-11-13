//
//  HKChatTextCell.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/8.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import Foundation
import YYText

private let kChatTextFont: UIFont = UIFont.systemFont(ofSize: 16)

class HKChatTextCell: HKChatBaseCell {

    /*! 这里的头像和昵称两个外联控件放在了父类中,步骤就是先外联到这里,再把代码拷贝到父类就行了 */
    //@IBOutlet weak var avatarImageView: UIImageView!
    //@IBOutlet weak var nicknameLabel: UILabel!
    
    //聊天的 三角指向图
    @IBOutlet weak var bubbleImageView: UIImageView!
    
    //这是个View,不是Label,不要被名字迷惑了...
    @IBOutlet weak var contentLabel: YYLabel! {
        didSet {
            contentLabel.font = kChatTextFont
            contentLabel.numberOfLines = 0
            contentLabel.textVerticalAlignment = YYTextVerticalAlignment.top
            contentLabel.displaysAsynchronously = false
            contentLabel.ignoreCommonProperties = true //如果只使用textLayout来做布局,设置为true以提高性能
            //点击高亮文字
            //public typealias YYTextAction = (UIView, NSAttributedString, NSRange, CGRect) -> Swift.Void
            contentLabel.highlightTapAction = ({[weak self] (containerView, text, range, rect) in
                self!.didTapRichLabelText(self!.contentLabel, textRange: range)
            })
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard let model = self.model else {
            return
        }
        
        self.contentLabel.size = model.richTextLayout!.textBoundingSize
        if model.fromMe {
            //value = 屏幕宽 - 头像的边距10 - 头像宽 - 气泡距离头像的 gap 值 - (文字宽 - 2倍的文字和气泡的左右距离 , 或者是最小的气泡图片距离)
            self.bubbleImageView.left = UIScreen.ts_width - kChatAvatarMarginLeft - kChatAvatarWidth - kChatBubbleMaginLeft - max(self.contentLabel.width + kChatBubbleWidthBuffer, kChatBubbleImageViewWidth)
        } else {
            //value = 距离屏幕左边的距离
            self.bubbleImageView.left = kChatBubbleLeft
        }
        
        //设置气泡的宽
        self.bubbleImageView.width = max(self.contentLabel.width + kChatBubbleWidthBuffer, kChatBubbleImageViewWidth)
        //气泡的高
        self.bubbleImageView.height = max(self.contentLabel.height + kChatBubbleHeightBuffer + kChatBubbleBottomTransparentHeight, kChatBubbleImageViewHeight)
        //value = 头像的底部 - 气泡透明间隔值
        self.bubbleImageView.top = self.nicknameLabel.bottom - kChatBubblePaddingTop
        //valeu = 气泡顶部 + 文字和气泡的差值
        self.contentLabel.top = self.bubbleImageView.top + kChatTextMarginTop
        //valeu = 气泡左边 + 文字和气泡的差值
        self.contentLabel.left = self.bubbleImageView.left + kChatTextMarginLeft
    }
    
    override func setCellContent(_ model: HKChatModel) {
        super.setCellContent(model)
        if let richTextLinePositionModifier = model.richTextLinePositionModifier {
            self.contentLabel.linePositionModifier = richTextLinePositionModifier
        }
        
        if let richTextLayout = model.richTextLayout {
            self.contentLabel.textLayout = richTextLayout
        }
        
        if let richTextAttributedString = model.richTextAttributedString {
            self.contentLabel.attributedText = richTextAttributedString
        }
        
        //拉伸图片区域
        let stretchImage = model.fromMe ? HKAsset.SenderTextNodeBkg.image : HKAsset.ReceiverTextNodeBkg.image
        //withCapInsets: 即在图片的上下左右距离各画一条线,组成一个框,在框内的才会被拉伸,框外的不会保持原样.
        let bubleImage = stretchImage.resizableImage(withCapInsets: UIEdgeInsetsMake(30, 28, 85, 28), resizingMode: .stretch)
        self.bubbleImageView.image = bubleImage
    }
    
    
    class func layoutHeight(_ model: HKChatModel) -> CGFloat {
        if model.cellHeight != 0 {
            return model.cellHeight
        }
        
        //解析富文本
        let attributedString = HKChatTextParser.parseText(model.messageContent!, font: kChatTextFont)!
        model.richTextAttributedString = attributedString
        
        //初始化排版布局对象
        let modifier = HKYYTextLinePositionModifier.init(font: kChatTextFont)
        model.richTextLinePositionModifier = modifier
        
        //初始化 YYTextContainer
        let textContainer: YYTextContainer = YYTextContainer()
        textContainer.size = CGSize(width: kChatTextMaxWidth, height: CGFloat.greatestFiniteMagnitude) //greatestFiniteMagnitude相当于CGFloat.max
        textContainer.linePositionModifier = modifier
        textContainer.maximumNumberOfRows = 0
        
        //设置 layout
        let textLayout = YYTextLayout(container: textContainer, text: attributedString)
        model.richTextLayout = textLayout
        
        //计算高度
        var height: CGFloat = kChatAvatarMarginTop + kChatBubblePaddingBottom
        let stringHeight = modifier.heightForLineCount(Int(textLayout!.rowCount))
        
        height += max(stringHeight + kChatBubbleHeightBuffer + kChatBubbleBottomTransparentHeight, kChatBubbleImageViewHeight)
        return model.cellHeight
    }
    
    
    /// 点击高亮文字
    ///
    /// - Parameters:
    ///   - label: YYLabel
    ///   - textRange: 高亮文字的NSRange, 不是Range
    fileprivate func didTapRichLabelText(_ label: YYLabel, textRange: NSRange) {
        //解析 userInfo 的文字
        let attributedString = label.textLayout!.text
        if textRange.location >= attributedString.length {
            return
        }
        guard let highlight: YYTextHighlight = attributedString.yy_attribute(YYTextHighlightAttributeName, at: UInt(textRange.location)) as? YYTextHighlight else {
            return
        }
        guard let info = highlight.userInfo, info.count > 0 else {
            return
        }
        guard let delegate = self.delegate else {
            return
        }
        
        if let phone: String = info[kChatTextKeyPhone] as? String {
            delegate.cellDidTapedPhone(self, phoneString: phone)
        }
        
        if let URL: String = info[kChatTextKeyURL] as? String {
            delegate.cellDidTapedLink(self, linkString: URL)
        }
    }
}










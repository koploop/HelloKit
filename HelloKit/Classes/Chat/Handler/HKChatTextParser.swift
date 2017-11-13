//
//  HKChatTextParser.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/10.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import Foundation
import YYText


/*! 聊天内容解析,分区出文字/表情/URL/电话/... */

public let kChatTextKeyPhone = "phone"
public let kChatTextKeyURL = "URL"

class HKChatTextParser: NSObject {

    class func parseText(_ text: String, font: UIFont) -> NSMutableAttributedString? {
        if text.characters.count == 0 {
            return nil
        }
        
        let attributedText: NSMutableAttributedString = NSMutableAttributedString(string: text)
        attributedText.yy_font = font
        attributedText.yy_color = UIColor.black
        
        //匹配电话
        self.enumeratePhoneParser(attributedText)
        //匹配URL
        self.enumerateURLParser(attributedText)
        //匹配表情
        self.enumerateEmotionParser(attributedText, fontSize: font.pointSize)
        
        return attributedText;
    }
    
    /**
     匹配电话
     
     - parameter attributedText: 富文本
     */
    fileprivate class func enumeratePhoneParser(_ attributedText: NSMutableAttributedString) {
        
        // 正则筛选电话号
        // match方法返回的是一个NSTextCheckingResult,它有两个属性,resultType和range. 标示内容类型和对应的范围
        let phonesResults = HKChatTextParserHelper.regexPhoneNumber.matches(
            in: attributedText.string,
            options: [.reportProgress],
            range: attributedText.yy_rangeOfAll()
        )
        for phone: NSTextCheckingResult in phonesResults {
            if phone.range.location == NSNotFound && phone.range.length <= 1 {
                continue
            }
            
            //初始化要高亮显示的内容的背景对象
            let highlightBorder = HKChatTextParserHelper.highlightBorder
            //设置电话号码高亮
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(phone.range.location)) == nil) {
                attributedText.yy_setColor(UIColor.init(ts_hexString: "#1F79FD"), range: phone.range)
                let highlight = YYTextHighlight()
                highlight.setBackgroundBorder(highlightBorder)
                
                let stringRange = attributedText.string.rangeFromNSRange(nsRange: phone.range)!
                highlight.userInfo = [kChatTextKeyPhone: attributedText.string.substring(with: stringRange)]
                attributedText.yy_setTextHighlight(highlight, range: phone.range)
            }
        }
    }
    
    
    /// 匹配URL
    ///
    /// - Parameter attributedText: 富文本
    fileprivate class func enumerateURLParser(_ attributedText: NSMutableAttributedString) {
        
        let URLResult = HKChatTextParserHelper.regexURLs.matches(
            in: attributedText.string,
            options: [.reportProgress],
            range: attributedText.yy_rangeOfAll())
        
        for URL: NSTextCheckingResult in URLResult {
            if URL.range.location == NSNotFound && URL.range.length <= 1 {
                continue
            }
            
            let highlightBorder = HKChatTextParserHelper.highlightBorder
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(URL.range.location)) == nil) {
                attributedText.yy_setColor(UIColor.init(ts_hexString: "#1F79FD"), range: URL.range)
                let highlight = YYTextHighlight()
                highlight.setBackgroundBorder(highlightBorder)
                
                let StringRange = attributedText.string.rangeFromNSRange(nsRange: URL.range)!
                highlight.userInfo = [kChatTextKeyURL : attributedText.string.substring(with: StringRange)]
                attributedText.yy_setTextHighlight(highlight, range: URL.range)
            }
        }
    }
    
    
    /// 匹配表情
    ///
    /// - Parameters:
    ///   - attributedText: 富文本
    ///   - fontSize: 字体大小
    fileprivate class func enumerateEmotionParser(_ attributedText: NSMutableAttributedString, fontSize: CGFloat) {
        
        let emotionResults = HKChatTextParserHelper.regexEmotions.matches(
            in: attributedText.string,
            options: [.reportProgress],
            range: attributedText.yy_rangeOfAll())
        
        var emoClipLength: Int = 0
        for emotion: NSTextCheckingResult in emotionResults {
            if emotion.range.location == NSNotFound && emotion.range.length <= 1 {
                continue
            }
            var range: NSRange = emotion.range
            range.location -= emoClipLength
            
            if (attributedText.yy_attribute(YYTextHighlightAttributeName, at: UInt(range.location)) != nil) {
                continue
            }
            if (attributedText.yy_attribute(YYTextAttachmentAttributeName, at: UInt(range.location)) != nil) {
                continue
            }
            
            let imageName = attributedText.string.substring(with: attributedText.string.rangeFromNSRange(nsRange: range)!)
            guard let theImageName = HKEmojiDictionary[imageName] else {
                continue
            }
            
            //QQ表情的文件名称
            let imageString = "\(HKConfig.ExpressionBundleName)/\(theImageName)"
            let emojiText = NSMutableAttributedString.yy_attachmentString(withEmojiImage: UIImage.init(named: imageString)!, fontSize: fontSize + 1)
            attributedText.replaceCharacters(in: range, with: emojiText!)
            
            emoClipLength += range.length - 1
        }
    }
}


// MARK: - HKChatTextParserHelper Class

class HKChatTextParserHelper {
    
    //高亮的文字背景色
    class var highlightBorder: YYTextBorder {
        get {
            let highlightBorder = YYTextBorder()
            highlightBorder.insets = UIEdgeInsetsMake(-2, 0, -2, 0)
            highlightBorder.fillColor = UIColor.init(ts_hexString: "#D4D1D1")
            return highlightBorder
        }
    }
    
    //正则匹配表情
    class var regexEmotions: NSRegularExpression {
        get {
            let regularExpression = try! NSRegularExpression(pattern: "\\[[^\\[\\]]+?\\]", options: .caseInsensitive)
            return regularExpression
        }
    }
    
    //正则匹配URL www.a.com 或者 http://www.a.com 的类型
    class var regexURLs: NSRegularExpression {
        get {
            let regex: String = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|^[a-zA-Z0-9]+(\\.[a-zA-Z0-9]+)+([-A-Z0-9a-z_\\$\\.\\+!\\*\\(\\)/,:;@&=\\?~#%]*)*"
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            return regularExpression
        }
    }
    
    //正则匹配电话 7-25 位的数字, 010-62104321, 0373-5957800, 010-62104321-230
    class var regexPhoneNumber: NSRegularExpression {
        get {
            let regex = "([\\d]{7,25}(?!\\d))|((\\d{3,4})-(\\d{7,8}))|((\\d{3,4})-(\\d{7,8})-(\\d{1,4}))"
            let regularExpression = try! NSRegularExpression(pattern: regex, options: [.caseInsensitive])
            return regularExpression
        }
    }
    
}


// MARK: - Extension String + Range

fileprivate extension String {
    
    
    /// Range转NSRange
    ///
    /// - Parameter range: Range
    /// - Returns: NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        let utf16View = self.utf16
        let from = range.lowerBound.samePosition(in: utf16View)
        let to = range.upperBound.samePosition(in: utf16View)
        return NSMakeRange(utf16View.distance(from: utf16View.startIndex, to: from),
                           utf16View.distance(from: from, to: to))
    }
    
    
    
    //系统提供的有rangeFromNSRange方法
    /// NSRange 转 Range
    ///
    /// - Parameter nsRange: NSRange
    /// - Returns: Range
//    func range(from nsRange: NSRange) -> Range<String.Index>? {
//        guard
//            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
//            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
//            let from = String.Index.init(from16, within: self),
//            let to = String.Index.init(to16, within: self)
//            else {
//            return nil
//        }
//        return from ..< to
//    }
}


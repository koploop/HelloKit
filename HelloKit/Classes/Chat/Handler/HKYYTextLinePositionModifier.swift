//
//  HKYYTextLinePositionModifier.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/13.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import YYText

private let ascentScale: CGFloat = 0.84
private let descentScale: CGFloat = 0.16

class HKYYTextLinePositionModifier: NSObject, YYTextLinePositionModifier {

    internal var font: UIFont // 基准字体 (例如 Heiti SC/PingFang SC)
    fileprivate var paddingTop: CGFloat = 2
    fileprivate var paddingBottom: CGFloat = 2
    fileprivate var lineHeightMultiple: CGFloat
    
    required init(font: UIFont) {
        if #available(iOS 9, *) {
            self.lineHeightMultiple = 1.23
        } else {
            self.lineHeightMultiple = 1.1925
        }
        self.font = font
        super.init()
    }
    
    func heightForLineCount(_ lineCount: Int) -> CGFloat {
        if lineCount == 0 {
            return 0
        }
        
        let ascent: CGFloat = self.font.pointSize * ascentScale
        let descent: CGFloat = self.font.pointSize * descentScale
        let lineHeight: CGFloat = self.font.pointSize * self.lineHeightMultiple
        return self.paddingTop + self.paddingBottom + ascent + descent + CGFloat(lineCount - 1) * lineHeight
    }
    
    // MARK: - @delegate YYTextLinePositionModifier
    func modifyLines(_ lines: [YYTextLine], fromText text: NSAttributedString, in container: YYTextContainer) {
        let ascent: CGFloat = self.font.pointSize * ascentScale
        let lineHeight: CGFloat = self.font.pointSize * self.lineHeightMultiple
        for line: YYTextLine in lines {
            var position: CGPoint = line.position
            position.y = self.paddingTop + ascent + CGFloat(line.row) * lineHeight
            line.position = position
        }
    }
    
    // MARK: - @delegate NSCopying
    func copy(with zone: NSZone? = nil) -> Any {
        let one = type(of: self).init(font: self.font)
        return one
    }
    
}

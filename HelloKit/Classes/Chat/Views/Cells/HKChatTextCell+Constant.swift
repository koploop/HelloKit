//
//  HKChatTextCell+Constant.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/9.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation
import UIKit

let kChatTextLeft: CGFloat = 72                                             //消息在左边的时候， 文字距离屏幕左边的距离
let kChatTextMaxWidth: CGFloat = UIScreen.ts_width - kChatTextLeft - 82    //消息在右边， 70：文本离屏幕左的距离，  82：文本离屏幕右的距离
let kChatTextMarginTop: CGFloat = 12                                        //文字的顶部和气泡顶部相差 12 像素
let kChatTextMarginBottom: CGFloat = 11                                     //文字的底部和气泡底部相差 11 像素
let kChatTextMarginLeft: CGFloat = 17                                       //文字的左边 和气泡的左边相差 17 ,包括剪头部门
let kChatBubbleWidthBuffer: CGFloat = kChatTextMarginLeft*2                 //气泡比文字的宽度多出的值
let kChatBubbleBottomTransparentHeight: CGFloat = 11                        //气泡底部的透明高度 11
let kChatBubbleHeightBuffer: CGFloat = kChatTextMarginTop + kChatTextMarginBottom  //文字的顶部 + 文字底部距离
let kChatBubbleImageViewHeight: CGFloat = 54                                //气泡最小高 54 ，防止拉伸图片变形
let kChatBubbleImageViewWidth: CGFloat = 50                                 //气泡最小宽 50 ，防止拉伸图片变形
let kChatBubblePaddingTop: CGFloat = 3                                      //气泡顶端有大约 3 像素的透明部分，需要和头像持平
let kChatBubbleMaginLeft: CGFloat = 5                                       //气泡和头像的 gap 值：5
let kChatBubblePaddingBottom: CGFloat = 8                                   //气泡距离底部分割线 gap 值：8
let kChatBubbleLeft: CGFloat = kChatAvatarMarginLeft + kChatAvatarWidth + kChatBubbleMaginLeft  //气泡距离屏幕左的距


extension HKChatTextCell {
    
    
}

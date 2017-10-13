//
//  HKChatCellDelegate.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/12.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation

@objc protocol HKChatCellDelegate: class {
    /**
     点击了 cell 本身
     */
    @objc optional func cellDidTaped(_ cell: HKChatBaseCell)
    
    /**
     点击了 cell 的头像
     */
    func cellDidTapedAvatarImage(_ cell: HKChatBaseCell)
    
    /**
     点击了 cell 的图片
     */
    func cellDidTapedImageView(_ cell: HKChatBaseCell)
    
    /**
     点击了 cell 中文字的 URL
     */
    func cellDidTapedLink(_ cell: HKChatBaseCell, linkString: String)
    
    /**
     点击了 cell 中文字的 电话
     */
    func cellDidTapedPhone(_ cell: HKChatBaseCell, phoneString: String)
    
    /**
     点击了声音 cell 的播放 button
     */
    func cellDidTapedVoiceButton(_ cell: HKChatBaseCell, isPlayingVoice: Bool)
}

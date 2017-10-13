//
//  HKMessageModel.swift
//  HelloKit
//
//  Created by Weelh on 2017/4/29.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import ObjectMapper

class HKMessageModel: NSObject, HKModelProtocol {
    
    var middleImageURL : String?
    var unreadNumber: Int?
    var nickName: String?
    var messageFromType: MessageFromType = .Personal
    var messageContentType: MessageContentType = .Text
    // uuid 每个人,群,公众号对应一个id
    var chatId: String?
    var latestMessage: String?
    var dateString: String?
    
    // 拼接最后一条消息类型
    var lastMessage: String? {
        get {
            switch self.messageContentType {
            case .Text, .System:
                return self.latestMessage
            case .Image:
                return "[图片]"
            case .Voice:
                return "[语音]"
            case .File:
                return "[文件]"
            default:
                return ""
            }
        }
    }
    
    required init?(map: Map) {
        
    }
    
    /*! 使用 ObjectMapper SDK 将Json转为model */
    func mapping(map: Map) {
        middleImageURL <- map["avatar_url"]
        unreadNumber <- map["message_unread_num"]
        nickName <- map["nickname"]
        messageFromType <- (map["meesage_from_type"], EnumTransform<MessageFromType>())
        messageContentType <- (map["last_message.message_content_type"], EnumTransform<MessageContentType>())
        chatId <- map["userid"]
        latestMessage <- map["last_message.message"]
        dateString <- (map["last_message.timestamp"], TransformerTimestampToTimeAgo)
    }
}

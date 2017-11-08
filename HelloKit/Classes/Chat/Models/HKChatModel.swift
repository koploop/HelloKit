//
//  HKChatModel.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/12.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import YYText
import ObjectMapper

class HKChatModel: NSObject, HKModelProtocol {
    
    var audioModel: HKChatAudioModel?
    var imageModel: HKChatImageModel?
    var chatSendId: String?
    var chatReceiveId: String?
    var device: String?
    var messageContent: String?
    var messageId: String?
    var messageContentType: MessageContentType = .Text
    var timestamp: String?
    var messageFromType: MessageFromType = .Group
    
    //以下是为了配合UI来使用
    var fromMe: Bool {
        return self.chatSendId == UserInstance.userId
    }
    var richTextLayout: YYTextLayout?
    var richTextLinePositionModifier: HKYYTextLinePositionModifier?
    var richTextAttributedString: NSMutableAttributedString?
    var messageSendSuccessType: MessageSendSuccessType = .Failed //发送消息的状态
    var cellHeight: CGFloat = 0 //计算的高度储存使用，默认0
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audioModel <- map["audioInfo"]
        chatSendId <- map["chat_send_id"]
        chatReceiveId <- map["chat_receive_id"]
        device <- map["device"]
        messageContent <- map["message"]
        messageId <- map["message_id"]
        messageContentType <- (map["message_type"], EnumTransform<MessageContentType>())
        imageModel <- map["picInfo"]
        timestamp <- map["timestamp"]
        messageFromType <- (map["type"], EnumTransform<MessageFromType>())  //消息来源类型, 个人，群组，公众号？
    }
    
    //自定义时间 model
    init(timestamp: String) {
        super.init()
        self.timestamp = timestamp
        self.messageContent = self.timeDate.chatTimeString
        self.messageContentType = .Time
    }
    
    //自定义发送文本的 ChatModel
    init(text: String) {
        super.init()
        self.timestamp = String(format: "%f", Date.milliseconds)
        self.messageContent = text
        self.messageContentType = .Text
        self.chatSendId = UserInstance.userId!
    }
    
    //自定义发送声音的 ChatModel
    init(audioModel: HKChatAudioModel) {
        super.init()
        self.timestamp = String(format: "%f", Date.milliseconds)
        self.messageContent = "[声音]"
        self.messageContentType = .Voice
        self.audioModel = audioModel
        self.chatSendId = UserInstance.userId!
    }
    
    //自定义发送图片的 ChatModel
    init(imageModel: HKChatImageModel) {
        super.init()
        self.timestamp = String(format: "%f", Date.milliseconds)
        self.messageContent = "[图片]"
        self.messageContentType = .Image
        self.imageModel = imageModel
        self.chatSendId = UserInstance.userId!
    }
    
    override init() {
        super.init()
    }
}


extension HKChatModel {
    //后一条数据是否比前一条数据 多了 2 分钟以上
    func isLateForTwoMinutes(_ targetModel: HKChatModel) -> Bool {
        //11是秒，服务器时间精确到毫秒，做一次判断
        guard self.timestamp!.length > 11 else {
            return false
        }
        
        guard targetModel.timestamp!.length > 11 else {
            return false
        }
        
        let nextSeconds = Double(self.timestamp!)!/1000
        let previousSeconds = Double(targetModel.timestamp!)!/1000
        return (nextSeconds - previousSeconds) > 120
    }
    
    var timeDate: Date {
        get {
            let seconds = Double(self.timestamp!)!/1000
            let timeInterval: TimeInterval = TimeInterval(seconds)
            return Date(timeIntervalSince1970: timeInterval)
        }
    }
}


extension Date {
    
}

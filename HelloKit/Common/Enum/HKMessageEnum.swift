//
//  HKMessageEnum.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/9/29.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation
import UIKit


/*! 性别类型 */
enum GenderType: Int {
    case Female = 0
    case Male
}

/*! 消息类型 */
enum MessageContentType: String {
    case Text   = "0"
    case Image  = "1"
    case Voice  = "2"
    case System = "3"
    case File   = "4"
    case Time   = "110"
}

/*! 消息来源类型 */
enum MessageFromType: String {
    case System             = "0"
    case Personal           = "1"
    case Group              = "2"
    case PublicServer       = "3"
    case PublicSubscribe    = "4"
    
    //每种类型对应的站位图(getter方法)
    var placeHolderImage: UIImage {
        switch self {
        case .Personal:
            return HKAsset.Icon_avatar.image
        case .System, .Group, .PublicServer, .PublicSubscribe:
            return HKAsset.Icon_avatar.image
        }
    }
}

/*! 消息发送状态类型 */
enum MessageSendSuccessType: Int {
    case Success = 0
    case Failed
    case Sending
}





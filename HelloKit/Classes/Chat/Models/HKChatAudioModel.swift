//
//  HKChatAudioModel.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/12.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import ObjectMapper

class HKChatAudioModel: NSObject {

    var audioId: String?
    var audioURL: String?
    var bitRate: String?
    var channels: String?
    var createTime: String?
    var duration: Float?
    var fileSize: String?
    var formatName: String?
    var keyHash: String?
    var mimeType: String?
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        audioId <- map["audio_id"]
        audioURL <- map["audio_url"]
        bitRate <- map["bit_rate"]
        channels <- map["channels"]
        createTime <- map["ctime"]
        duration <- (map["duration"], TransformerStringToFloat)
        fileSize <- map["file_size"]
        formatName <- map["format_name"]
        keyHash <- map["key_hash"]
        mimeType <- map["mime_type"]
    }
}

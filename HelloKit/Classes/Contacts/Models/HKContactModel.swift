//
//  HKContactModel.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/13.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import ObjectMapper


@objc class HKContactModel: NSObject, HKModelProtocol {
    var avatarSmallURL: String?
    var chineseName: String?
    var nameSpell: String?
    var phone: String?
    var userId: String?
    
    required init?(map: Map) {
        
    }
    
    override init() {
        super.init()
    }
    
    func mapping(map: Map) {
        avatarSmallURL <- map["avatar_url"]
        chineseName <- map["name"]
        nameSpell <- map["name_spell"]
        phone <- map["phone"]
        userId <- map["userid"]
    }
    
    func compareContact(_ contactModel: HKContactModel) -> ComparisonResult {
        let result = self.nameSpell?.compare(contactModel.nameSpell!)
        return result!
    }
}


enum ContactModelEnum: Int {
    case newFriends = 0
    case publicAccout
    case groupChat
    case tags
    
    var model: HKContactModel {
        let model = HKContactModel()
        switch self {
        case .groupChat:
            model.chineseName = "群聊"
            model.avatarSmallURL = "http://ww1.sinaimg.cn/large/6a011e49jw1f18hercci7j2030030glf.jpg"
            return model
        case .publicAccout:
            model.chineseName = "公众号"
            model.avatarSmallURL = "http://ww2.sinaimg.cn/large/6a011e49jw1f18hkv6i5kj20300303yb.jpg"
            return model
        case .newFriends:
            model.chineseName = "新的朋友"
            model.avatarSmallURL = "http://ww4.sinaimg.cn/large/6a011e49jw1f18hftp0foj2030030dfn.jpg"
            return model
        case .tags:
            model.chineseName = "标签"
            model.avatarSmallURL = "http://ww2.sinaimg.cn/large/6a011e49jw1f18hh48jr3j2030030743.jpg"
            return model
        }
    }
}

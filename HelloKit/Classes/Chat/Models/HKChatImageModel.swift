//
//  HKChatImageModel.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/12.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import ObjectMapper

class HKChatImageModel: NSObject {
    
    var imageHeight: CGFloat?
    var imageWidth: CGFloat?
    var imageId: String?
    var originalURL: String?
    var thumbURL: String?
    var localStoreName: String?
    var localThumbnailImage: UIImage? {
        if let theLocalStoreName = localStoreName {
            let path = ImageFilesManager.cachePathForKey(theLocalStoreName)
            return UIImage(contentsOfFile: path!)
        } else {
            return nil
        }
    }
    
    override init() {
        super.init()
    }
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        imageHeight <- (map["height"], TransformerStringToCGFloat)
        imageWidth <- (map["width"], TransformerStringToCGFloat)
        originalURL <- map["original_url"]
        thumbURL <- map["thumb_url"]
        imageId <- map["image_id"]
    }
    
}

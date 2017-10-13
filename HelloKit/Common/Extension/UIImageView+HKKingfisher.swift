//
//  UIImageView+HKKingfisher.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/9/30.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation
import Kingfisher


public extension UIImageView {
    
    
    /**
     通过URL设置UIImageView
     
     - parameter urlString:     地址
     - parameter placeholder:   占位图
     */
    func hk_setImageWithURLString(_ urlString: String?, placeholderImage placeholder: UIImage? = nil) {
        guard let URLString = urlString, let URL = URL(string: URLString) else {
            print("Wrong URLString")
            return
        }
        self.kf.setImage(with: URL)
    }
    
    /**
     设置UIImageView的URL和圆角大小
     
     - parameter URLString:         图片地址
     - parameter placeholder:       占位图
     - parameter cornerRadiusRatio: 圆角大小
     */
    func hk_setCornerRadiusImageWithURLString(_ URLString: String?,
                                              placeholderImage placeholder: UIImage? = nil,
                                              cornerRadiusRatio: CGFloat? = nil) {
        
    }
    
    /**
     设置图片
     
     - parameter URLString:         图片地址
     - parameter placeholderImage:  占位图
     - parameter cornerRadiusRatio: 圆角
     - parameter processBlock:      进度
     */
    func hk_setRoundImageWithURLString(_ URLString: String?,
                                       placeholderImage placeholder: UIImage? = nil,
                                       cornerRadiusRatio: CGFloat? = nil,
                                       processBlock: ImageDownloaderProgressBlock? = nil) {
        
        guard let URLString = URLString, let URL = URL(string: URLString) else {
            print("Wrong URL String")
            return
        }
        let memoryImage = KingfisherManager.shared.cache.retrieveImageInMemoryCache(forKey: URLString)
        let diskImage = KingfisherManager.shared.cache.retrieveImageInDiskCache(forKey: URLString)
        // 先从内存中去图片,如果取不到,则从缓存中取,否则从网络下载
        guard let image = memoryImage ?? diskImage else {
            let optionInfo: KingfisherOptionsInfo = [
                .forceRefresh
            ]
            KingfisherManager.shared.downloader.downloadImage(with: URL, options: optionInfo, progressBlock: processBlock) {
                
                (image, error, imageURL, originalData) -> () in
                if let image = image, let originalDate = originalData {
                    
                    DispatchQueue.global(qos: .default).async {
                        let roundedImage = image.ts_roundWithCornerRadius(image.size.width * (cornerRadiusRatio ?? 0.5))
                        KingfisherManager.shared.cache.store(roundedImage, original: originalDate, forKey: URLString, toDisk: true, completionHandler: {
                            self.hk_setImageWithURLString(URLString)
                        })
                    }
                }
            }
            return
        }
        self.image = image
    }
    
}

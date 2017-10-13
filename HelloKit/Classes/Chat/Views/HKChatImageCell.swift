//
//  HKChatImageCell.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/12.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import Foundation


let kChatImageMaxWidth: CGFloat = 125 //最大的图片宽度
let kChatImageMinWidth: CGFloat = 50 //最小的图片宽度
let kChatImageMaxHeight: CGFloat = 150 //最大的图片高度
let kChatImageMinHeight: CGFloat = 50 //最小的图片高度

class HKChatImageCell: HKChatBaseCell {

    @IBOutlet weak var chatImageView: UIImageView!
    @IBOutlet weak var coverImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //图片点击
        let tap = UITapGestureRecognizer()
        self.chatImageView.addGestureRecognizer(tap)
        self.chatImageView.isUserInteractionEnabled = true
        tap.rx.event.subscribe({
            [weak self] _ in
            if let strongSelf = self {
                guard let delegate = strongSelf.delegate else {
                    return
                }
                delegate.cellDidTapedImageView(strongSelf)
            }
        }).addDisposableTo(self.disposeBag)
    }
    
    override func setCellContent(_ model: HKChatModel) {
        super.setCellContent(model)
        if let localThumbnailImage = model.imageModel!.localThumbnailImage {
            self.chatImageView.image = localThumbnailImage
        } else {
            self.chatImageView.hk_setImageWithURLString(model.imageModel?.thumbURL)
        }
        self.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
        
    }
    
    class func layoutHeight(_ model: HKChatModel) -> CGFloat {
        if model.cellHeight != 0 {
            return model.cellHeight
        }
        return 40
    }
}

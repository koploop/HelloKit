//
//  HKMessageTableViewCell.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/9/28.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import Kingfisher

class HKMessageTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.avatarImageView.layer.masksToBounds = true
        self.avatarImageView.layer.cornerRadius = self.avatarImageView.width/2
    }
    
    func setCellContent(_ model: HKMessageModel) {
        self.avatarImageView.hk_setImageWithURLString(model.middleImageURL, placeholderImage: model.messageFromType.placeHolderImage)
        self.lastMessageLabel.text = model.lastMessage!
        self.dateLabel.text = model.dateString!
        self.nameLabel.text = model.nickName!
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}

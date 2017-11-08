//
//  HKContactTableViewCell.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/13.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit

class HKContactTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCellContent(_ model: HKContactModel) {
        self.avatarImageView.hk_setImageWithURLString(model.avatarSmallURL, placeholderImage: HKAsset.Icon_avatar.image)
        self.userNameLabel.text = model.chineseName
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

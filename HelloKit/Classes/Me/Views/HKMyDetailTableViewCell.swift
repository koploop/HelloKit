//
//  HKMyDetailTableViewCell.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/20.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit

class HKMyDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var weChatIdLabel: UILabel!
    @IBOutlet weak var qrCodeImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

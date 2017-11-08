//
//  HKDiscoverTableViewCell.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/19.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit

class HKDiscoverTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessoryType = .disclosureIndicator
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

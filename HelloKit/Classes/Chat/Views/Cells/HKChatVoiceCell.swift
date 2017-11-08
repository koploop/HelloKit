//
//  HKChatVoiceCell.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/8.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import Foundation

class HKChatVoiceCell: HKChatBaseCell {
    
    class func layoutHeight(_ model: HKChatModel) -> CGFloat {
        if model.cellHeight != 0 {
            return model.cellHeight
        }
        return 40
    }
}

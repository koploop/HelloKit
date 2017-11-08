//
//  HKChatButton.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/1.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit

class HKChatButton: UIButton {

    var showTypingKeyboard:Bool
    
    required init?(coder aDecoder: NSCoder) {
        self.showTypingKeyboard = true
        super.init(coder: aDecoder)
    }

}

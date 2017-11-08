//
//  UITableView+ChatAdditions.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/6.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    
    func reloadData(_ completion: @escaping ()->()) {
        UIView.animate(withDuration: 0, animations: { 
            self.reloadData()
        }, completion: { _ in
            completion()
        })
    }
    
    
}

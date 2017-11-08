//
//  NSDictionary+HKExtension.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/13.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation



// MARK: - 字典相加
public func + <K, V>(left: Dictionary<K, V>, right: Dictionary<K, V>) -> Dictionary<K, V> {
    var map = Dictionary<K, V>()
    for (k, v) in left {
        map[k] = v
    }
    for (k, v) in right {
        map[k] = v
    }
    return map
}

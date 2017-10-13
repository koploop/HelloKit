//
//  HKConfig.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/12.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation


class HKConfig {
    static let testUserID = "wx1234skjksmsjdfwe234"
    static let ExpressionBundle = Bundle(url: Bundle.main.url(forResource: "Expression", withExtension: "bundle")!)
    static let ExpressionBundleName = "Expression.bundle"
    static let ExpressionPlist = Bundle.main.path(forResource: "Expression", ofType: "plist")
}

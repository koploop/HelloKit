//
//  HKAppMacros.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/12.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation
import UIKit


//AppDelegate
let HKAppDelegate = UIApplication.shared.delegate as! AppDelegate

// 沙盒文档路径
let kSandDocumentPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last!

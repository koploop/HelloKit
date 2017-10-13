//
//  HKTabBar.swift
//  HelloKit
//
//  Created by Weelh on 2017/4/21.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import TimedSilver
import Cent
import RxSwift

class HKTabBar: UITabBarController {

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewController()
    }

    // MARK: - LayoutViews
    func setupViewController() {
        let titleArray = ["微信", "通讯录", "发现", "我的"]
        
        let normalImagesArray = [
            HKAsset.Tabbar_mainframe.image,
            HKAsset.Tabbar_contacts.image,
            HKAsset.Tabbar_discover.image,
            HKAsset.Tabbar_me.image,
            // UIImage(asset: .Tabbar_mainframe) 这种写法创建的image是可选值
        ]
        
        let selectedImagesArray = [
            HKAsset.Tabbar_mainframeHL.image,
            HKAsset.Tabbar_contactsHL.image,
            HKAsset.Tabbar_discoverHL.image,
            HKAsset.Tabbar_meHL.image
        ]
        
        let viewControllerArray = [
            HKMessageViewController.initFromNib(),
            HKContactViewController.ts_initFromNib(),
            HKDiscoverViewController.initFromNib(),
            HKMeViewController.initFromNib()
        ]
        
        /// 为每个控制器添加一个导航控制器
        let navigationVCArray = NSMutableArray()
        for (index, controller) in viewControllerArray.enumerated() {
            controller.tabBarItem.title = titleArray.get(index: index)
            controller.tabBarItem.image = normalImagesArray.get(index: index).withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.selectedImage = selectedImagesArray.get(index: index).withRenderingMode(.alwaysOriginal)
            controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName: UIColor.lightGray], for: .normal)
            controller.tabBarItem.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.tabbarSelectedTextColor], for: .selected)
            
            let navigationController = UINavigationController(rootViewController: controller)
            navigationVCArray.add(navigationController)
        }
        self.viewControllers = navigationVCArray.mutableCopy() as! [UINavigationController]
    }
    
}

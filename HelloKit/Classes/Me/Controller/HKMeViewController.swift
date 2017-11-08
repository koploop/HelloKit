//
//  HKMeViewController.swift
//  HelloKit
//
//  Created by Weelh on 2017/4/28.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit

class HKMeViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    fileprivate var dataSource:[[(name: String, iconImage: UIImage)]] {
        return [
            [
                ("相册", HKAsset.MoreMyAlbum.image),
                ("收藏", HKAsset.MoreMyFavorites.image),
                ("钱包", HKAsset.MoreMyBankCard.image),
                ("优惠券", HKAsset.MyCardPackageIcon.image)
            ],
            
            [
                ("表情", HKAsset.MoreExpressionShops.image)
            ],
            
            [
                ("设置", HKAsset.MoreSetting.image)
            ]
        ]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "我"
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        self.listTableView.backgroundColor = UIColor.viewBackgroundColor
        self.listTableView.ts_registerCellNib(HKDiscoverTableViewCell.self)
        self.listTableView.ts_registerCellNib(HKMyDetailTableViewCell.self)
        self.listTableView.tableFooterView = UIView()
    
    }
    
    deinit {
        log.verbose("deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}



extension HKMeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return self.dataSource[section - 1].count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell: HKMyDetailTableViewCell = tableView.ts_dequeueReusableCell(HKMyDetailTableViewCell.self)
            return cell
        } else {
            let cell:HKDiscoverTableViewCell = tableView.ts_dequeueReusableCell(HKDiscoverTableViewCell.self)
            let item: (name: String, iconImage: UIImage) = self.dataSource[indexPath.section - 1][indexPath.row]
            cell.titleLabel.text = item.name
            cell.iconImageView.image = item.iconImage
            return cell
        }
    }
}

extension HKMeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 88.0
        } else {
            return 44.0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 15
        } else {
            return 20
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.00001
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}





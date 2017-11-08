//
//  HKDiscoverViewController.swift
//  HelloKit
//
//  Created by Weelh on 2017/4/28.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit

class HKDiscoverViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    
    // TSWeChat中组织数据源的方式是直接生成一个个元组放入数组中, 这里我们换一种方式,生成model
    var dataSource: [NSDictionary] = [] // var 就代表这是可变数组了
//    var dataSource_ = [NSDictionary]()
//    var dataSource__ = NSMutableArray()
//    var dataSource___: Array<NSDictionary> // 未初始化的一个数组
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "发现"
//        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.listTableView.backgroundColor = UIColor.viewBackgroundColor
        self.listTableView.ts_registerCellNib(HKDiscoverTableViewCell.self)
        self.listTableView.estimatedRowHeight = 44
        self.listTableView.tableFooterView = UIView()
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self
        
        self.generateDataSource()
    }

    func generateDataSource() {
        
        let model = HKDiscoverModel()
        model.image = HKAsset.Ff_IconShowAlbum.image
        model.title = "朋友圈"
        self.dataSource.append(["item": [model]])
        
        let model2 = HKDiscoverModel()
        model2.image = HKAsset.Ff_IconQRCode.image
        model2.title = "扫一扫"
        let model22 = HKDiscoverModel()
        model22.image = HKAsset.Ff_IconShake.image
        model22.title = "摇一摇"
        self.dataSource.append(["item": [model2, model22]])
        
        let model3 = HKDiscoverModel()
        model3.image = HKAsset.Ff_IconLocationService.image
        model3.title = "附近的人"
        let model33 = HKDiscoverModel()
        model33.image = HKAsset.Ff_IconBottle.image
        model33.title = "漂流瓶"
        self.dataSource.append(["item": [model3, model33]])
        
        let model4 = HKDiscoverModel()
        model4.image = HKAsset.Ff_IconLocationService.image
        model4.title = "游戏"
        self.dataSource.append(["item": [model4]])
        
        self.listTableView.reloadData()
    }

    deinit {
        log.verbose("deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension HKDiscoverViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = (self.dataSource[section]["item"] as! [HKDiscoverModel]).count
        return count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HKDiscoverTableViewCell = tableView.ts_dequeueReusableCell(HKDiscoverTableViewCell.self)
        let items = self.dataSource[indexPath.section]["item"] as! [HKDiscoverModel]
        let model = items[indexPath.row]
        cell.iconImageView.image = model.image
        cell.iconImageView.contentMode = .scaleAspectFit
        cell.titleLabel.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.listTableView.estimatedRowHeight
    }
}

extension HKDiscoverViewController: UITableViewDelegate {
    
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







//
//  HKMessageViewController.swift
//  HelloKit
//
//  Created by Weelh on 2017/4/24.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import Foundation
import TimedSilver
import SwiftyJSON

class HKMessageViewController: UIViewController {
    
    @IBOutlet weak var listTableView: UITableView!
    fileprivate var itemDataSource = [HKMessageModel]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "微信"
        self.view.backgroundColor = UIColor.viewBackgroundColor
        //TODO: 右上角加号按钮
        
        //初始化MessageCell
        self.listTableView.delegate = self;
        self.listTableView.dataSource = self;
        let reuseIdentifier = String(describing: HKMessageTableViewCell.self)
        let nib = UINib(nibName: reuseIdentifier, bundle: nil)
        self.listTableView.register(nib, forCellReuseIdentifier: reuseIdentifier)
        self.listTableView.estimatedRowHeight = 65;
        self.listTableView.tableFooterView = UIView()
        
        self.fetchData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    /// 获取对话数据
    fileprivate func fetchData() {
        guard let JSONData = Data.ts_dataFromJSONFile("message") else {
            return
        }
        let jsonObject = JSON(data: JSONData)
        if jsonObject != JSON.null {
            var list = [HKMessageModel]()
            for dict in jsonObject["data"].arrayObject! {
                guard let model = HKMapper<HKMessageModel>().map(JSON: dict as! [String: Any]) else {
                    continue
                }
                list.insert(model, at: list.count)
            }
            
            // 多插入几条数据,这样列表更长
            self.itemDataSource.insert(contentsOf: list, at: 0);
            self.listTableView.reloadData()
        }
    }
    
    deinit {
        log.verbose("deinit")
    }

}


// MARK: - UITableViewDelegate
extension HKMessageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let viewController: UIViewController = UIViewController.init()
        viewController.view.backgroundColor = UIColor.red
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension HKMessageViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: HKMessageTableViewCell = tableView.ts_dequeueReusableCell(HKMessageTableViewCell.self)
        cell.setCellContent(self.itemDataSource[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.listTableView.estimatedRowHeight
    }
}

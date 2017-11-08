//
//  HKContactViewController.swift
//  HelloKit
//
//  Created by Weelh on 2017/4/24.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import SwiftyJSON
import Cent

class HKContactViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet var footerView: UIView!
    @IBOutlet weak var totalCountLabel: UILabel!
    
    fileprivate var sortedkeys = [String]()
    fileprivate var dataDict: Dictionary<String, NSMutableArray>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "通讯录"
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.listTableView.ts_registerCellNib(HKContactTableViewCell.self)
        self.listTableView.estimatedRowHeight = 56;
        self.listTableView.tableFooterView = self.footerView
        self.listTableView.sectionIndexColor = UIColor.darkGray
        self.listTableView.delegate = self
        self.listTableView.dataSource = self
        
        
        self.fetchContactList()
    }
    
    func fetchContactList() {
        guard let JSONData = Data.ts_dataFromJSONFile("contact") else {
            return
        }
        let jsonObject = JSON(data: JSONData)
        if jsonObject != JSON.null {
            // 创建群聊和公共账号数据
            let topArray: NSMutableArray = [
                ContactModelEnum.newFriends.model,
                ContactModelEnum.groupChat.model,
                ContactModelEnum.tags.model,
                ContactModelEnum.publicAccout.model
            ]
            self.sortedkeys.append("")
            self.dataDict = ["": topArray]
            
            // 解析星标联系人数据
            if let startArray = jsonObject["data"][0].arrayObject, startArray.count > 0 {
                let tempList = NSMutableArray()
                for dict in startArray {
                    guard let model = HKMapper<HKContactModel>().map(JSON: dict as! [String: Any]) else {
                        continue
                    }
                    tempList.add(model)
                }
                tempList.sortedArray(using: #selector(HKContactModel.compareContact(_:)))
                self.sortedkeys.append("★")
                // 这里对 + 操作符做了一个扩展
                self.dataDict = self.dataDict! + ["★" : tempList]
            }
            
            
            // 解析联系人数据
            if let contactArray = jsonObject["data"][1].arrayObject, contactArray.count > 0 {
                let tempList = NSMutableArray()
                for dict in contactArray {
                    guard let model = HKMapper<HKContactModel>().map(JSON: dict as! [String : Any]) else {
                        continue
                    }
                    tempList.add(model)
                }
                
                self.totalCountLabel.text = String("\(tempList.count)位联系人")
                
                // 重新 a-z 排序
                var dataSource = Dictionary<String, NSMutableArray>()
                for index in 0..<tempList.count {
                    let contactModel = tempList[index] as! HKContactModel
                    guard let nameSpell: String = contactModel.nameSpell else {
                        continue
                    }
                    // 取出首字母
                    let firstLettery: String = nameSpell[0..<1].uppercased()
                    // 如果首字母key已经存在字典中,放入此model, 如果不存在,创建对应的key和对应数组
                    if let letterArray: NSMutableArray = dataSource[firstLettery] {
                        letterArray.add(contactModel)
                    } else {
                        let tempArray = NSMutableArray()
                        tempArray.add(contactModel)
                        dataSource[firstLettery] = tempArray
                    }
                }
                // 排序
                let sortedKeys = Array(dataSource.keys).sorted(by: <)
                self.sortedkeys.append(contentsOf: sortedKeys)
                self.dataDict = self.dataDict! + dataSource
            }
            self.listTableView.reloadData()
        }
    }
    
    deinit {
        log.verbose("deinit")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}


extension HKContactViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.sortedkeys.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataDict![self.sortedkeys[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HKContactTableViewCell.self), for: indexPath) as! HKContactTableViewCell
        
        guard indexPath.section < self.sortedkeys.count else {
            return cell
        }
        let key: String = self.sortedkeys[indexPath.section]
        let dataArray: NSMutableArray = self.dataDict![key]!
        cell.setCellContent(dataArray[indexPath.row] as! HKContactModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.listTableView.estimatedRowHeight
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        let title = self.sortedkeys[section]
        if title == "★" {
            return "星标朋友"
        }
        return title
    }
    
    func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard let _ = self.dataDict else {
            return []
        }
        let titles: [String] = self.sortedkeys as NSArray as! [String]
        return titles
    }
}

extension HKContactViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}



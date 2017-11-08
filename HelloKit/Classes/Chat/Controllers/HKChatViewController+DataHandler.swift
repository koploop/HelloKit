//
//  HKChatViewController+DataHandler.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/11/6.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation
import SwiftyJSON

/*! 从资源文件中获取聊天数据,计算出需要插入的数据和高度,更新TableView */

extension HKChatViewController {
    
    
    func firstFetchMessageList() {
        guard let list = self.fetchData() else {
            return
        }
        
        self.itemDataSource.insert(contentsOf: list, at: 0)
        self.listTableView.reloadData({[unowned self] _ in
            self.isReloading = false
        })
        self.listTableView.setContentOffset(CGPoint(x:0, y: CGFloat.greatestFiniteMagnitude), animated: false)
    }
    
    /*! 从文件中获取聊天数据 */
    func fetchData() -> [HKChatModel]? {
        guard let JSONData = Data.ts_dataFromJSONFile("chat") else {
            return nil
        }
        
        var list = [HKChatModel]()
        let jsonObj = JSON(data: JSONData)
        if jsonObj != JSON.null {
            var temp: HKChatModel?
            for dict in jsonObj["data"].arrayObject! {
                guard let model = HKMapper<HKChatModel>().map(JSON: dict as! [String : Any])  else {
                    continue
                }
                // 1. 刷新获取的第一条数据,加上时间model
                // 2. 当后面的数据比前面一条多出2分钟以上的时,加上时间model
                if temp == nil || model.isLateForTwoMinutes(temp!) {
                    guard let timestamp = model.timestamp else {
                        continue
                    }
                    list.insert(HKChatModel(timestamp: timestamp), at: list.count)
                }
                list.insert(model, at: list.count)
                temp = model
            }
        }
        return list
    }
    
    /*! 下拉加载更多 */
    func pullToLoadMore() {
        self.isEndRefresh = false
        self.indicatorView.startAnimating()
        self.isReloading = true
        
        let backgroundQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
        backgroundQueue.async(execute: {
            guard let list = self.fetchData() else {
                self.indicatorView.stopAnimating()
                self.isReloading = false
                return
            }
            sleep(1)
            DispatchQueue.main.async(execute: { () -> Void in
                self.itemDataSource.insert(contentsOf: list, at: 0)
                self.indicatorView.stopAnimating()
                self.updateTableWith(newRowCount: list.count)
                self.isEndRefresh = true
            })
        })
    }
    
    func updateTableWith(newRowCount count: Int) {
        var contentsOffset = self.listTableView.contentOffset
        
        UIView.setAnimationsEnabled(false)
        self.listTableView.beginUpdates()
        
        var heightForNewRows: CGFloat = 0
        var indexPaths = [IndexPath]()
        for i in 0 ..< count {
            let indexPath = IndexPath(row: i, section: 0)
            indexPaths.append(indexPath)
            
            heightForNewRows += self.tableView(self.listTableView, heightForRowAt: indexPath)
        }
        contentsOffset.y += heightForNewRows
        
        self.listTableView.insertRows(at: indexPaths, with: UITableViewRowAnimation.none)
        self.listTableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        self.listTableView.setContentOffset(contentsOffset, animated: false)
    }
    
}

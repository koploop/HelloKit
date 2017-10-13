//
//  HKChatViewController+CellEnums.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/13.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import Foundation
import UIKit

// MARK: - 为MessageContentType增加cell内容extension, 有效减少VC中的代码

extension MessageContentType {
    
    func chatCellHeight(_ model: HKChatModel) -> CGFloat {
        switch self {
        case .Text:
            return HKChatTextCell.layoutHeight(model)
        case .Image:
            return HKChatImageCell.layoutHeight(model)
        case .Voice:
            return HKChatVoiceCell.layoutHeight(model)
        case .System:
            return HKChatSystemCell.layoutHeight(model)
        case .File:
            return 60
        case .Time:
            return HKChatTimeCell.heightForCell()
        }
    }
    
    func chatCell(_ tableView: UITableView, indexPath: IndexPath, model: HKChatModel, viewController: HKChatViewController) -> UITableViewCell? {
        switch self {
        case .Text :
            let cell: HKChatTextCell = tableView.ts_dequeueReusableCell(HKChatTextCell.self)
            cell.delegate = viewController as? HKChatCellDelegate
            cell.setCellContent(model)
            return cell
            
        case .Image :
            let cell: HKChatImageCell = tableView.ts_dequeueReusableCell(HKChatImageCell.self)
            cell.delegate = viewController as? HKChatCellDelegate
            cell.setCellContent(model)
            
            return cell
            
        case .Voice:
            let cell: HKChatVoiceCell = tableView.ts_dequeueReusableCell(HKChatVoiceCell.self)
            cell.delegate = viewController as? HKChatCellDelegate
            cell.setCellContent(model)
            return cell
            
        case .System:
            let cell: HKChatSystemCell = tableView.ts_dequeueReusableCell(HKChatSystemCell.self)
            cell.setCellContent(model)
            return cell
            
        case .File:
            let cell: HKChatVoiceCell = tableView.ts_dequeueReusableCell(HKChatVoiceCell.self)
            cell.delegate = viewController as? HKChatCellDelegate
            cell.setCellContent(model)
            return cell
            
        case .Time :
            let cell: HKChatTimeCell = tableView.ts_dequeueReusableCell(HKChatTimeCell.self)
            cell.setCellContent(model)
            return cell
        }
    }
}

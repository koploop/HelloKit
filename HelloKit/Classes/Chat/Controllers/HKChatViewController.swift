//
//  HKChatViewController.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/11.
//  Copyright © 2017年 Weelh. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift


private let kChatViewController: CGFloat = 30

/// 聊天详情ViewController
class HKChatViewController: UIViewController {

    @IBOutlet var refreshView: UIView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    lazy var listTableView: UITableView = {
        let listTableView = UITableView(frame: CGRect.zero, style: .plain)
        listTableView.dataSource = self
        listTableView.delegate = self
        listTableView.backgroundColor = UIColor.clear
        listTableView.separatorStyle = .none
        listTableView.backgroundView = UIImageView(image: HKAsset.Chat_background.image)
        return listTableView
    }()
    
    var messageModel: HKMessageModel?
    var chatActionBarView: UIView!
    var actionBarPaddingBottomConstranit: Constraint?
    var keyboardHeightConstraint: NSLayoutConstraint?
    var emotionInputView: UIView!
    var shareMoreView: UIView!
    var voiceIndicatorView: UIView!
    let disposeBag = DisposeBag()
    var imagePicker: UIImagePickerController!
    var itemDataSource = [HKChatModel]()
    var isReloading: Bool = false
    var currentVoiceCell: UITableViewCell!
    var isEndRefresh: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.messageModel!.nickName!
        self.view.backgroundColor = UIColor.viewBackgroundColor
        self.navigationController!.interactivePopGestureRecognizer!.isEnabled = true
        
        // cell init
        self.listTableView.ts_registerCellNib(HKChatTextCell.self)
        self.listTableView.ts_registerCellNib(HKChatImageCell.self)
        self.listTableView.ts_registerCellNib(HKChatVoiceCell.self)
        self.listTableView.ts_registerCellNib(HKChatSystemCell.self)
        self.listTableView.ts_registerCellNib(HKChatTimeCell.self)
        
        // listTableview init
        self.listTableView.tableFooterView = UIView()
        self.listTableView.tableHeaderView = self.refreshView
        
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        log.verbose("deinit")
    }


}


// MARK: - Protocol UITableViewDelegate
extension HKChatViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - Protocol UITableViewDataSource
extension HKChatViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let chatModel = self.itemDataSource.get(index: indexPath.row) else {
            return HKChatBaseCell()
        }
        let type: MessageContentType = chatModel.messageContentType
        return type.chatCell(tableView, indexPath: indexPath, model: chatModel, viewController: self)!
    }
}



// MARK: - Protocol UIScrollViewDelegate
extension HKChatViewController: UIScrollViewDelegate {
    
}

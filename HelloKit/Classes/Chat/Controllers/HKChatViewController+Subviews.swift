//
//  HKChatViewController+Subviews.swift
//  HelloKit
//
//  Created by SuperMario@lvhan on 2017/10/31.
//  Copyright © 2017年 Weelh. All rights reserved.
//


/*! 设置子视图extension */
/*! 创建各种聊天view */


import Foundation
import UIKit

extension HKChatViewController {
    
    
    func setupSubviews(_ delegate: UITextViewDelegate) {
        self.setupActionBar(delegate)
        self.initListTableView(delegate)
        self.setupKeyboardInputView()
        self.setupVoiceIndicatorView()
    }
    
    /*! 设置操作栏 */
    fileprivate func setupActionBar(_ delegate: UITextViewDelegate) {
        self.chatActionBarView = UIView.ts_viewFromNib(HKChatActionBarView.self)
        self.chatActionBarView.delegate = (self as! HKChatActionBarViewDelegate)
        self.chatActionBarView.inputTextView.delegate = delegate
        
        self.view.addSubview(self.chatActionBarView)
        self.chatActionBarView.snp.makeConstraints { [weak self] (make) -> Void in
            guard let strongSelf = self else { return }
            make.left.equalTo(strongSelf.view.snp.left)
            make.right.equalTo(strongSelf.view.snp.right)
            strongSelf.actionBarPaddingBottomConstranit = make.bottom.equalTo(strongSelf.view.snp.bottom).constraint
            make.height.equalTo(kChatActionBarOriginalHeight)
        }
    }
    
    /*! 初始化聊天列表 */
    fileprivate func initListTableView(_ delegate: UITextViewDelegate) {
        let tap = UITapGestureRecognizer()
        tap.cancelsTouchesInView = false
        self.listTableView.addGestureRecognizer(tap)
        tap.rx.event.subscribe {[weak self] _ in
            guard let strongSelf = self else { return }
            
        }.addDisposableTo(self.disposeBag)
        
        self.view.addSubview(self.listTableView)
        
        self.listTableView.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(self.view)
            make.bottom.equalTo(self.chatActionBarView.snp.top)
        }
    }
    
    /*! 设置表情键盘,分享更多键盘 */
    fileprivate func setupKeyboardInputView() {
        
    }
    
    /*! 设置语音聊天框 */
    fileprivate func setupVoiceIndicatorView() {
        
    }
    
}

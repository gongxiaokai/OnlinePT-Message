//
//  ReplyCommentView.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config
import UITextView_Placeholder
import RxSwift
import RxCocoa
import IQKeyboardManagerSwift

class ReplyCommentView : NiblessView {
    let viewModel : ReplyVM
    
    /// 键盘是否显示
    var isKeyboardShown = false

    let textViewWidth = kScreenW - 2 * ReplyVM.Constant.margin - ReplyVM.Constant.commentSendWidth
    
    lazy var sendBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("发送", for: .normal)
        btn.setTitleColor(Theme.main.baseRed, for: .normal)
        return btn
    }()
    
    
    
    lazy var textView: UITextView = {
        let view = UITextView()
        view.placeholder = "评论"
        view.backgroundColor = Theme.main.separatLine
        view.isScrollEnabled = false
        return view
    }()
    
    var toUserId = ""
    
    
    init(frame: CGRect = .zero, viewModel: ReplyVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModel()
        setupStyle()
        setupLayout()
    }
    
}


extension ReplyCommentView {
    public func clear() {
        textView.text = ""
        textView.attributedText = NSAttributedString(string: "")
    }
}

extension ReplyCommentView : ViewBaseProtocol {
    
    
    func setupStyle() {
        addSubview(textView)
        addSubview(sendBtn)
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillHideNotification)
            .subscribe(onNext: { (_) in
                IQKeyboardManager.shared.enableAutoToolbar = true
                self.removeFromSuperview()
            }).disposed(by: bag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardWillShowNotification)
            .subscribe(onNext: { (_) in
                IQKeyboardManager.shared.enableAutoToolbar = false
                self.toUserId = ""
                self.isKeyboardShown = true
            }).disposed(by: bag)
        
        NotificationCenter.default.rx
            .notification(UIResponder.keyboardDidHideNotification)
            .subscribe(onNext: { (_) in
                self.isKeyboardShown = false
            }).disposed(by: bag)
    }
    
    func setupLayout() {
        let newSize = self.getTextViewSize()
        textView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.height.equalTo(newSize.height)
            $0.width.equalTo(textViewWidth)
            $0.left.equalTo(ReplyVM.Constant.margin)
            $0.top.equalTo(ReplyVM.Constant.margin).priority(.high)
            $0.bottom.equalTo(-ReplyVM.Constant.margin).priority(.high)
        }
        
        sendBtn.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalTo(-ReplyVM.Constant.margin)
            $0.width.equalTo(ReplyVM.Constant.commentSendWidth)
        }
    }
    
    func bindViewModel() {
        textView.rx.text.changed
            .map{ [unowned self] _ in
                let newSize = self.getTextViewSize()
                guard newSize.height < 100 else {
                    self.textView.isScrollEnabled = true
                    return
                }
                self.textView.snp.remakeConstraints{
                    $0.centerY.equalToSuperview()
                    $0.height.equalTo(newSize.height)
                    $0.width.equalTo(self.textViewWidth)
                    $0.left.equalTo(ReplyVM.Constant.margin)
                    $0.top.equalTo(ReplyVM.Constant.margin).priority(.high)
                    $0.bottom.equalTo(-ReplyVM.Constant.margin).priority(.high)
                }
            }.subscribe().disposed(by: bag)
        
        
        
        viewModel.replyToUserSubject
            .map{ reply -> String in
                self.toUserId = reply.id
                return reply.name
            }
            .map{ $0.isEmpty ? "评论" : "回复 \($0)" }
            .bind(to: textView.rx.placeholder)
            .disposed(by: bag)
        
        
        sendBtn.rx.tap
            .map{ (self.toUserId,self.textView.text) }
            .bind(to: viewModel.commentSubject)
            .disposed(by: bag)
    }
    
}

extension ReplyCommentView {
    private func getTextViewSize() -> CGSize{
        let width = textViewWidth
        let maxSize = CGSize(width:width,height:400)
        let newSize = self.textView.sizeThatFits(maxSize)
        return newSize
    }
}



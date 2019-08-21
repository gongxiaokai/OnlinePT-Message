//
//  LikeMsgVC.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config
import URLNavigator
import RxSwift
import RxCocoa

class LikeMsgVC : NiblessViewController {
    private let viewModel = LikeMsgVM()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        setupNavStyle()
        bindViewModel()
    }
    
    internal override func loadView() {
        view = LikeMsgRootView(viewModel: viewModel)
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension LikeMsgVC {
    private func setupNavStyle() {
        navigation.item.title = "赞和评论"
        navigation.bar.alpha = 0
        
        let rightItem = UIBarButtonItem(title: "一键清空", style: .done, target: self, action: nil)
        rightItem.tintColor = .white
        let attributedString : [NSAttributedString.Key : Any] = [
            .font: UIFont(name: Theme.font.normal, size: 15)
        ]
        rightItem.setTitleTextAttributes(attributedString, for: .normal)
        rightItem.setTitleTextAttributes(attributedString, for: .highlighted)
        rightItem.rx.tap
            .subscribe(onNext: { (_) in
                logger.debug("点击一键清空")
            })
            .disposed(by: bag)
        navigation.item.rightBarButtonItem = rightItem
    }
    
    private func bindViewModel() {
        viewModel.fetchData()
        viewModel.tapReplySubject
            .subscribe(onNext: { (id) in
                _ = Navigator.that?.push("reply".formatScheme())
            }).disposed(by: bag)
    }
}

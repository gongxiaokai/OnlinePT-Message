//
//  SystemMsgVC.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/13.
//

import Foundation
import OnlinePT_Config
import OnlinePT_BaseCore
import URLNavigator
import RxSwift
import RxCocoa
/// vc 示例
class SystemMsgVC : NiblessViewController {
    private let viewModel = SystemMsgVM()
    
    internal override func viewDidLoad() {
        super.viewDidLoad()
        setupNavStyle()
        bindViewModel()
    }
    
    internal override func loadView() {
        view = SystemMsgRootView(viewModel: viewModel)
    }
    
    internal override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension SystemMsgVC {
    private func setupNavStyle() {
        navigation.item.title = "系统消息"
        navigation.bar.alpha = 0
    }
    
    private func bindViewModel() {
        viewModel.fetchData()
    }
    
}

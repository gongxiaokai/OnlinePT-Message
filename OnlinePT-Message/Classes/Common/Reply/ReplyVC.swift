//
//  ReplyVC.swift
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

public class ReplyVC : NiblessViewController {
    let viewModel = ReplyVM()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavStyle()
        bindViewModel()
    }
    
    public override func loadView() {
        view = ReplyRootView(viewModel: viewModel)
    }
    
    func setupNavStyle() {
        navigation.item.title = "快捷回复"
        navigation.bar.alpha = 0
    }
    
    func bindViewModel() {
        
    }
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.fetchData()
    }
}

//
//  PostMomentVC.swift
//  OnlinePT-Post
//
//  Created by gongwenkai on 2019/7/29.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config
import URLNavigator
import RxSwift
import RxCocoa

public class MessageRootVC : NiblessViewController {
    let viewModel = HomeRootVM()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupNavStyle()
        bindViewModel()
        view.backgroundColor = Theme.main.baseBg
        
        let likeBtn = UIButton()
        likeBtn.setTitle("点赞和评论", for: .normal)
        likeBtn.setTitleColor(Theme.main.baseTitle, for: .normal)
        likeBtn.rx.tap.subscribe(onNext: { (_) in
            _ = Navigator.that?.push("likeMsg".formatScheme())
        }).disposed(by: bag)
        
        let systemBtn = UIButton()
        systemBtn.setTitle("系统消息", for: .normal)
        systemBtn.setTitleColor(Theme.main.baseTitle, for: .normal)
        systemBtn.rx.tap.subscribe(onNext: { (_) in
            _ = Navigator.that?.push("systemMsg".formatScheme())
        }).disposed(by: bag)
        
        let stackView = UIStackView(arrangedSubviews: [likeBtn,systemBtn])
        stackView.axis = .vertical
        view.addSubview(stackView)
        stackView.snp.makeConstraints{
            $0.center.equalToSuperview()
        }
    }
    
//    public override func loadView() {
//        view = HomeRootView(viewModel: viewModel)
//    }
    
    func setupNavStyle() {
        navigation.item.title = "消息"
        navigation.bar.alpha = 0
    }
    
    func bindViewModel() {
//        viewModel.momentDetailSubject
//            .subscribe(onNext: { (_) in
//                _ = Navigator.that?.push("momentDetail".formatScheme())
//            }).disposed(by: bag)
    }
    
}

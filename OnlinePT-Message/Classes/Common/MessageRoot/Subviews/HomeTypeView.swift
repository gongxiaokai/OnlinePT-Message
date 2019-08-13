//
//  HomeTypeView.swift
//  OnlinePT-Home
//
//  Created by gongwenkai on 2019/8/5.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config
import SnapKit

class HomeTypeView : NiblessView {
    
    let viewModel : HomeRootVM
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.main.baseRed
        return view
    }()
    
    lazy var featuredBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("精选", for: .normal)
        btn.titleLabel?.fontSize(Theme.font.normal, size: 18)
        btn.setTitleColor(Theme.main.white, for: .normal)
        btn.setTitleColor(Theme.main.baseRed, for: .disabled)
        return btn
    }()
    
    lazy var followBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("关注", for: .normal)
        btn.titleLabel?.fontSize(Theme.font.normal, size: 18)
        btn.setTitleColor(Theme.main.white, for: .normal)
        btn.setTitleColor(Theme.main.baseRed, for: .disabled)
        return btn
    }()
    
    lazy var newestBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("最新", for: .normal)
        btn.titleLabel?.fontSize(Theme.font.normal, size: 18)
        btn.setTitleColor(Theme.main.white, for: .normal)
        btn.setTitleColor(Theme.main.baseRed, for: .disabled)
        return btn
    }()
    
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [featuredBtn,followBtn,newestBtn])
        stack.distribution = UIStackView.Distribution.equalCentering
        stack.axis = NSLayoutConstraint.Axis.horizontal
        stack.alignment = UIStackView.Alignment.center
        return stack
    }()
    
    init(frame: CGRect = .zero, viewModel: HomeRootVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupStyle()
        setupLayout()
        bindViewModel()
    }
}


extension HomeTypeView : ViewBaseProtocol {
    func setupStyle() {
        addSubview(stackView)
        addSubview(indicatorView)
    }
    
    func setupLayout() {
        stackView.snp.makeConstraints{
            $0.top.bottom.equalToSuperview()
            $0.width.equalTo(kScreenW - (2 * HomeRootVM.Constant.typeMargin))
            $0.centerX.equalToSuperview()
        }
        
        indicatorView.snp.makeConstraints{
            $0.height.equalTo(3)
            $0.top.equalTo(featuredBtn.snp.bottom)
            $0.width.equalTo(featuredBtn)
            $0.centerX.equalTo(featuredBtn)
        }
    }
    
    func restState() {
        featuredBtn.isEnabled = true
        followBtn.isEnabled = true
        newestBtn.isEnabled = true
    }
    
    func bindViewModel() {
        featuredBtn.rx.tap
            .map{ _ in HomeRootVM.HomeType.featured }
            .bind(to: viewModel.currentTypeSubject)
            .disposed(by: bag)
        
        followBtn.rx.tap
            .map{ _ in HomeRootVM.HomeType.followed }
            .bind(to: viewModel.currentTypeSubject)
            .disposed(by: bag)
        
        newestBtn.rx.tap
            .map{ _ in HomeRootVM.HomeType.newest }
            .bind(to: viewModel.currentTypeSubject)
            .disposed(by: bag)
        
        viewModel.currentTypeSubject
            .map{ self.getCurrentButton($0) }
            .map{ btn in
                self.restState()
                btn.isEnabled.toggle()
                UIView.animate(withDuration: 0.15, animations: {
                    self.indicatorView.snp.remakeConstraints{
                        $0.height.equalTo(3)
                        $0.top.equalTo(btn.snp.bottom)
                        $0.width.equalTo(btn)
                        $0.centerX.equalTo(btn)
                    }
                    self.layoutIfNeeded()
                })
                
            }
            .subscribe()
            .disposed(by: bag)

    }
    
    private func getCurrentButton(_ type: HomeRootVM.HomeType) -> UIButton {
        switch type {
        case .featured:
            return featuredBtn
        case .followed:
            return followBtn
        case .newest:
            return newestBtn
        }
    }
}

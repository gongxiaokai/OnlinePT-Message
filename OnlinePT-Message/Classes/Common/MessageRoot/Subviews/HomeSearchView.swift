//
//  HomeSearchView.swift
//  OnlinePT-Home
//
//  Created by gongwenkai on 2019/8/6.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config


class HomeSearchView : NiblessView {
    let viewModel : HomeRootVM
    
    lazy var searchView: UISearchBar = {
        let view = UISearchBar()
        view.backgroundImage = UIImage()
        view.barTintColor = Theme.main.baseRed
        view.tintColor =  Theme.main.baseRed
        view.placeholder = "搜索"
        view.barStyle = UIBarStyle.default
        view.isTranslucent = true
        view.searchBarStyle = UISearchBar.Style.minimal
        view.setSearchFieldBackgroundImage(UIColor.clear.getImage(size: CGSize(width: 200, height: 50)), for: .normal)
        return view
    }()
    
    init(frame: CGRect = .zero, viewModel: HomeRootVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setupStyle()
        setupLayout()
        bindViewModel()
        
    }
}

extension HomeSearchView : ViewBaseProtocol {
    func setupStyle() {
        backgroundColor = UIColor.init(white: 1, alpha: 0.5)
        addSubview(searchView)
        
        if let textField = searchView.value(forKey: "_searchField") as? UITextField {
            let placehodler = NSAttributedString(string: "搜索", attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.white
                ])
            textField.attributedPlaceholder = placehodler
        }
    }
    func setupLayout() {
        searchView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
    func bindViewModel() {
    
    }
}

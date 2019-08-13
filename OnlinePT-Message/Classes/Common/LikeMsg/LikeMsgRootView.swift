//
//  LikeMsgRootView.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import OnlinePT_Config
import OnlinePT_BaseCore
import RxCocoa
import RxSwift
import RxDataSources
import Kingfisher

/// 主页面
class LikeMsgRootView : NiblessView {
    let viewModel : LikeMsgVM
    
    var dataSource : RxTableViewSectionedAnimatedDataSource<LikeMsgSection>!
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: CGFloat.leastNormalMagnitude))
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.sectionFooterHeight = CGFloat.leastNormalMagnitude
        table.sectionHeaderHeight = LikeMsgVM.Constant.margin
        table.contentInset = UIEdgeInsets(top: LikeMsgVM.Constant.margin, left: 0, bottom: LikeMsgVM.Constant.margin, right: 0)
        table.register(LikeMsgCell.self,
                       forCellReuseIdentifier: LikeMsgCell.reuseIdentifier)
        return table
    }()
    
    
    init(frame: CGRect = .zero, viewModel: LikeMsgVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModel()
        setupStyle()
        setupLayout()
    }
    
    func getDataSource() -> RxTableViewSectionedAnimatedDataSource<LikeMsgSection>{
        return RxTableViewSectionedAnimatedDataSource<LikeMsgSection>(
            animationConfiguration: AnimationConfiguration(reloadAnimation: .none),
            configureCell: { ds, tv, ip, it in
                switch ds[ip] {
                case .item(let data):
                    let cell: LikeMsgCell = tv.dequeueReusableCell(forIndexPath: ip)
                    cell.name = data.name
                    cell.date = data.date
                    cell.content = data.content
                    cell.imageUrl = data.imageUrl
                    cell.isVideo = data.isVideo
                    return cell
                }
        })
    }
    
}


extension LikeMsgRootView : ViewBaseProtocol {
    func setupStyle() {
        backgroundColor = Theme.main.baseBg
        addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints{
            $0.left.equalTo(LikeMsgVM.Constant.margin)
            $0.right.equalTo(-LikeMsgVM.Constant.margin)
            $0.bottom.equalTo(layoutMarginsGuide).offset(-LikeMsgVM.Constant.margin)
            $0.top.equalTo(layoutMarginsGuide).offset(LikeMsgVM.Constant.margin)
        }
    }
    
    func bindViewModel() {
        dataSource = getDataSource()
        viewModel.result?
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        
        dataSource.decideViewTransition =  { _, _, _ in .reload }
        
        
        
        tableView.rx.modelSelected(LikeMsgSectionType.self)
            .bind(to: viewModel.tableDidSelectedSubject).disposed(by: bag)
    }
}


//
//  ReplyRootView.swift
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
class ReplyRootView : NiblessView {
    let viewModel : ReplyVM
    
    var dataSource : RxTableViewSectionedAnimatedDataSource<ReplySection>!
    
    lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: CGFloat.leastNormalMagnitude))
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.sectionFooterHeight = CGFloat.leastNormalMagnitude
        table.sectionHeaderHeight = ReplyVM.Constant.margin
        table.contentInset = UIEdgeInsets(top: ReplyVM.Constant.margin,
                                          left: 0,
                                          bottom: ReplyVM.Constant.margin,
                                          right: 0)
        table.register(ReplyInfoCell.self,
                       forCellReuseIdentifier: ReplyInfoCell.reuseIdentifier)
        return table
    }()
    
    
    init(frame: CGRect = .zero, viewModel: ReplyVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModel()
        setupStyle()
        setupLayout()
    }
    
    func getDataSource() -> RxTableViewSectionedAnimatedDataSource<ReplySection>{
        return RxTableViewSectionedAnimatedDataSource<ReplySection>(
            animationConfiguration: AnimationConfiguration(reloadAnimation: .none),
            configureCell: { ds, tv, ip, it in
                switch ds[ip] {
                case .followed(let data):
                    let cell: ReplyInfoCell = tv.dequeueReusableCell(forIndexPath: ip)
                    cell.title = data.name
                    return cell
                }
        })
    }
    
    
    
}


extension ReplyRootView : ViewBaseProtocol {
    func setupStyle() {
        backgroundColor = Theme.main.baseBg
        addSubview(tableView)
    }
    
    func setupLayout() {
        tableView.snp.makeConstraints{
            $0.left.equalTo(ReplyVM.Constant.margin)
            $0.right.equalTo(-ReplyVM.Constant.margin)
            $0.bottom.equalTo(layoutMarginsGuide).offset(-ReplyVM.Constant.margin)
            $0.top.equalTo(layoutMarginsGuide).offset(ReplyVM.Constant.margin)
        }
    }
    
    func bindViewModel() {
        dataSource = getDataSource()
        viewModel.result?
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        
        dataSource.decideViewTransition =  { _, _, _ in .reload }
        
        
        
        tableView.rx.modelSelected(ReplySectionType.self)
            .bind(to: viewModel.tableDidSelectedSubject)
            .disposed(by: bag)
    }
    

}

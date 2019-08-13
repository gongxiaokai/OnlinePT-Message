//
//  SystemMsgRootView.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/13.
//

import Foundation
import OnlinePT_Config
import OnlinePT_BaseCore
import RxCocoa
import RxSwift
import RxDataSources
import Kingfisher

/// rootView 示例
class SystemMsgRootView : NiblessView {
    private let viewModel : SystemMsgVM
    
    private var dataSource : RxTableViewSectionedAnimatedDataSource<SystemMsgSection>!
    
    private lazy var tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.backgroundColor = .clear
        table.separatorStyle = .none
        table.showsVerticalScrollIndicator = false
        table.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: kScreenW, height: CGFloat.leastNormalMagnitude))
        table.rowHeight = UITableView.automaticDimension
        table.estimatedRowHeight = UITableView.automaticDimension
        table.sectionFooterHeight = CGFloat.leastNormalMagnitude
        table.sectionHeaderHeight = SystemMsgVM.Constant.margin
        table.contentInset = UIEdgeInsets(top: SystemMsgVM.Constant.margin,
                                          left: 0,
                                          bottom: SystemMsgVM.Constant.margin,
                                          right: 0)
        table.register(SystemMsgCell.self,
                       forCellReuseIdentifier: SystemMsgCell.reuseIdentifier)
        return table
    }()
    
    
    init(frame: CGRect = .zero, viewModel: SystemMsgVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModel()
        setupStyle()
        setupLayout()
    }
    
}

//MARK: 私有方法
extension SystemMsgRootView {
    private func getDataSource() -> RxTableViewSectionedAnimatedDataSource<SystemMsgSection>{
        return RxTableViewSectionedAnimatedDataSource<SystemMsgSection>(
            animationConfiguration: AnimationConfiguration(reloadAnimation: .none),
            configureCell: { ds, tv, ip, it in
                switch ds[ip] {
                case .msg(let data):
                    let cell: SystemMsgCell = tv.dequeueReusableCell(forIndexPath: ip)
                    cell.content = data.content
                    cell.date = data.date
                    return cell
                }
        })
    }
}

//MARK: 页面构造
extension SystemMsgRootView : ViewBaseProtocol {
    internal func setupStyle() {
        backgroundColor = Theme.main.baseBg
        addSubview(tableView)
    }
    
    internal func setupLayout() {
        tableView.snp.makeConstraints{
            $0.left.equalTo(SystemMsgVM.Constant.margin)
            $0.right.equalTo(-SystemMsgVM.Constant.margin)
            $0.bottom.equalTo(layoutMarginsGuide).offset(-SystemMsgVM.Constant.margin)
            $0.top.equalTo(layoutMarginsGuide).offset(SystemMsgVM.Constant.margin)
        }
    }
    
    internal func bindViewModel() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        dataSource = getDataSource()
        dataSource.decideViewTransition =  { _, _, _ in .reload }
        
        viewModel.result?
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        tableView.rx.modelSelected(SystemMsgSectionType.self)
            .bind(to: viewModel.tableDidSelectedSubject)
            .disposed(by: bag)
    }
    
}


extension SystemMsgRootView : UITableViewDelegate {
//    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        cell.contentView.backgroundColor = .white
//        cell.layer.mask = nil
//        cell.layer.sublayers?.removeAll(where: {$0.name?.contains("separatLine") ?? false})
//        let cellbounds = cell.bounds
//        
//        let rowsCount = tableView.numberOfRows(inSection: indexPath.section)
//        
//        guard rowsCount > 1 else {
//            let path = UIBezierPath(roundedRect: cell.bounds,
//                                    byRoundingCorners: [.topLeft,.topRight,.bottomLeft,.bottomRight],
//                                    cornerRadii: CGSize(width: 5, height: 0))
//            let shapLayer = CAShapeLayer()
//            shapLayer.lineWidth = 1
//            shapLayer.strokeColor = UIColor.clear.cgColor
//            shapLayer.fillColor = UIColor.clear.cgColor
//            shapLayer.path = path.cgPath
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = path.cgPath
//            cell.layer.mask = maskLayer
//            return
//        }
//        
//        let separatLineLayer = CALayer()
//        separatLineLayer.frame = CGRect(x: 0,
//                                        y: cell.bounds.height - 1,
//                                        width: cell.bounds.width,
//                                        height: 1)
//        separatLineLayer.backgroundColor = Theme.main.separatLine.cgColor
//        separatLineLayer.name = "separatLine"
//        
//        if indexPath.row == 0 {
//            let path = UIBezierPath(roundedRect: cellbounds,
//                                    byRoundingCorners: [.topLeft,.topRight],
//                                    cornerRadii: CGSize(width: 5, height: 0))
//            let shapLayer = CAShapeLayer()
//            shapLayer.lineWidth = 1
//            shapLayer.strokeColor = UIColor.clear.cgColor
//            shapLayer.fillColor = UIColor.clear.cgColor
//            shapLayer.path = path.cgPath
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = path.cgPath
//            cell.layer.mask = maskLayer
//            cell.layer.addSublayer(shapLayer)
//            cell.layer.addSublayer(separatLineLayer)
//        }else if indexPath.row ==  rowsCount - 1 {
//            let path = UIBezierPath(roundedRect: cell.bounds,
//                                    byRoundingCorners: [.bottomLeft,.bottomRight],
//                                    cornerRadii: CGSize(width: 5, height: 0))
//            let shapLayer = CAShapeLayer()
//            shapLayer.lineWidth = 1
//            shapLayer.strokeColor = UIColor.clear.cgColor
//            shapLayer.fillColor = UIColor.clear.cgColor
//            shapLayer.path = path.cgPath
//            let maskLayer = CAShapeLayer()
//            maskLayer.path = path.cgPath
//            cell.layer.mask = maskLayer
//        }else {
//            cell.layer.addSublayer(separatLineLayer)
//        }
//    }
    
}

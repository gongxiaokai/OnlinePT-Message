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
import IQKeyboardManagerSwift

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
        table.register(ReplyCommentCell.self,
                       forCellReuseIdentifier: ReplyCommentCell.reuseIdentifier)
        return table
    }()
    
    
    lazy var commentView: ReplyCommentView = {
        let view = ReplyCommentView(viewModel: viewModel)
        view.backgroundColor = .white
        view.isHidden = true
        return view
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
                case .info(let data):
                    let cell: ReplyInfoCell = tv.dequeueReusableCell(forIndexPath: ip)
                    cell.content = data.content
                    cell.imageUrl = data.imageUrl
                    cell.date = data.date
                    return cell
                case .comment(let data):
                    let cell: ReplyCommentCell = tv.dequeueReusableCell(forIndexPath: ip)
                    cell.profile = data.profile
                    cell.fromName = data.name
                    cell.toName = data.toReply
                    cell.date = data.date
                    cell.content = data.content
                    return cell
                }

        })
    }
    
    
}


extension ReplyRootView : ViewBaseProtocol {
    func setupStyle() {
        backgroundColor = Theme.main.baseBg
        addSubview(tableView)
        addSubview(commentView)
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
        tableView.rx.setDelegate(self).disposed(by: bag)
        dataSource = getDataSource()
        viewModel.result?
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        dataSource.decideViewTransition =  { _, _, _ in .reload }
        
        tableView.rx.modelSelected(ReplySectionType.self)
            .filter{ _ in !(self.commentView.isKeyboardShown) }
            .bind(to: viewModel.tableDidSelectedSubject)
            .disposed(by: bag)
        
        viewModel.replyToUserSubject
            .subscribe(onNext: { [unowned self](_) in
                self.showCommentView()
            }).disposed(by: bag)
        
    }

}

extension ReplyRootView {
    private func showCommentView() {
        commentView.removeFromSuperview()
        commentView.isHidden = false
        commentView.clear()
        addSubview(commentView)
        commentView.snp.makeConstraints{
            $0.left.right.equalToSuperview()
            $0.height.greaterThanOrEqualTo(ReplyVM.Constant.commentViewHeight)
            $0.bottom.equalTo(self.layoutMarginsGuide)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1, execute: {
            self.commentView.textView.becomeFirstResponder()
        })
    }
}




//MARK: UITableViewDelegate - config corner and separatline
extension ReplyRootView : UITableViewDelegate {
    
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layer.mask = nil
        cell.layer.sublayers?.removeAll(where: {$0.name?.contains("separatLine") ?? false})
        let cellbounds = cell.bounds
        
        let rowsCount = tableView.numberOfRows(inSection: indexPath.section)
        
        guard rowsCount > 1 else {
            let path = UIBezierPath(roundedRect: cell.bounds,
                                    byRoundingCorners: [.topLeft,.topRight,.bottomLeft,.bottomRight],
                                    cornerRadii: CGSize(width: 5, height: 0))
            let shapLayer = CAShapeLayer()
            shapLayer.lineWidth = 1
            shapLayer.strokeColor = UIColor.clear.cgColor
            shapLayer.fillColor = UIColor.clear.cgColor
            shapLayer.path = path.cgPath
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            cell.layer.mask = maskLayer
            return
        }
        
        let separatLineLayer = CALayer()
        separatLineLayer.frame = CGRect(x: 0,
                                        y: cell.bounds.height - 1,
                                        width: cell.bounds.width,
                                        height: 1)
        separatLineLayer.backgroundColor = Theme.main.separatLine.cgColor
        separatLineLayer.name = "separatLine"
        
        if indexPath.row == 0 {
            let path = UIBezierPath(roundedRect: cellbounds,
                                    byRoundingCorners: [.topLeft,.topRight],
                                    cornerRadii: CGSize(width: 5, height: 0))
            let shapLayer = CAShapeLayer()
            shapLayer.lineWidth = 1
            shapLayer.strokeColor = UIColor.clear.cgColor
            shapLayer.fillColor = UIColor.clear.cgColor
            shapLayer.path = path.cgPath
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            cell.layer.mask = maskLayer
            cell.layer.addSublayer(shapLayer)
            cell.layer.addSublayer(separatLineLayer)
        }else if indexPath.row ==  rowsCount - 1 {
            let path = UIBezierPath(roundedRect: cell.bounds,
                                    byRoundingCorners: [.bottomLeft,.bottomRight],
                                    cornerRadii: CGSize(width: 5, height: 0))
            let shapLayer = CAShapeLayer()
            shapLayer.lineWidth = 1
            shapLayer.strokeColor = UIColor.clear.cgColor
            shapLayer.fillColor = UIColor.clear.cgColor
            shapLayer.path = path.cgPath
            let maskLayer = CAShapeLayer()
            maskLayer.path = path.cgPath
            cell.layer.mask = maskLayer
        }else {
            cell.layer.addSublayer(separatLineLayer)
        }
    }
    
}


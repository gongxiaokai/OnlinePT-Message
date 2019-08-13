//
//  PostMomentRootView.swift
//  OnlinePT-Post
//
//  Created by gongwenkai on 2019/7/29.
//

import Foundation
import OnlinePT_Config
import OnlinePT_BaseCore
import RxCocoa
import RxSwift
import RxDataSources
import SnapKit
import RxGesture
/// 主页面
class HomeRootView : NiblessView {
    let viewModel : HomeRootVM
    
    var dataSource : RxCollectionViewSectionedAnimatedDataSource<HomeRootSection>!
    
    var heightConstraint : Constraint?
    
    
    lazy var collectionView : UICollectionView = {
        let layout = WaterfallLayout()
        layout.minimumLineSpacing = HomeRootVM.Constant.margin
        layout.minimumInteritemSpacing = HomeRootVM.Constant.margin
//        layout.estimatedItemSize = .automaticSize
        layout.dataSource = self
        layout.headerHeight = HomeRootVM.Constant.margin
//        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        layout.sectionInset = UIEdgeInsets(top: HomeRootVM.Constant.margin,
                                           left: HomeRootVM.Constant.margin,
                                           bottom: HomeRootVM.Constant.margin,
                                           right: HomeRootVM.Constant.margin)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.register(HomeRootCell.self,
                      forCellWithReuseIdentifier: HomeRootCell.reuseIdentifier)
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    
    lazy var typeView: HomeTypeView = {
        let view = HomeTypeView(frame: .zero, viewModel: viewModel)
        return view
    }()
    
    lazy var searchView : HomeSearchView = {
        let view = HomeSearchView(viewModel: viewModel)
        view.makeRoundedCorners(17*kScale)
        return view
    }()
    
    init(frame: CGRect = .zero, viewModel: HomeRootVM) {
        self.viewModel = viewModel
        super.init(frame: frame)
        bindViewModel()
        setupStyle()
        setupLayout()
        viewModel.fetchData()
    }
    
    func getDataSource() -> RxCollectionViewSectionedAnimatedDataSource<HomeRootSection>{
        return RxCollectionViewSectionedAnimatedDataSource<HomeRootSection>(
            animationConfiguration: AnimationConfiguration(reloadAnimation: .none),
            configureCell: { ds, tv, ip, it in
                switch ds[ip] {
                case .postMoment(let data):
                    let cell : HomeRootCell = tv.dequeueReusableCell(forIndexPath: ip)
                    cell.cellHeight = data.height
                    cell.profileImageView.isUserInteractionEnabled = true
//                    cell.profileImageView.rx.tapGesture(configuration: { (rec, _) in
//                        rec.cancelsTouchesInView = false
//                    })
//                        .when(.recognized)
//                        .subscribe(onNext: { (tap) in
//                            logger.debug(tap.location(in: cell))
//                        }).disposed(by: cell.bag)
                    return cell
                }
            })
       
    }
    
    
    
}


extension HomeRootView : ViewBaseProtocol {
    func setupStyle() {
        backgroundColor = Theme.main.baseBg
        addSubview(typeView)
        addSubview(searchView)
        addSubview(collectionView)
        
    }
    
    func setupLayout() {
        
        typeView.snp.makeConstraints{
            $0.left.right.top.equalTo(layoutMarginsGuide)
            $0.height.equalTo(50*kScale)
        }
        
        searchView.snp.makeConstraints{
            $0.left.equalTo(57*kScale)
            $0.right.equalTo(-57*kScale)
            $0.top.equalTo(typeView.snp.bottom)
            $0.height.equalTo(34*kScale)
        }
        
        collectionView.snp.makeConstraints{
            $0.left.equalToSuperview()
            $0.right.equalToSuperview()
            $0.top.equalTo(searchView.snp.bottom).offset(HomeRootVM.Constant.margin)
            $0.bottom.equalTo(layoutMarginsGuide).offset(-HomeRootVM.Constant.margin)
        }
    }
    
    func bindViewModel() {
        dataSource = getDataSource()
        viewModel.result?
            .bind(to: collectionView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
        
        dataSource.decideViewTransition =  { _, _, _ in .reload }
        
//        dataSource.configureSupplementaryView = { (ds, cv, kind, ip) -> UICollectionReusableView in
//            let view : TestHeaderView = cv.dequeueReusableView(forIndexPath: ip, kind: kind)
//            return view
//        }
        
//        collectionView.rx.setDelegate(self).disposed(by: bag)
        
        collectionView.rx.modelSelected(HomeRootSectionType.self)
            .subscribe(onNext: { [unowned self](type) in
                self.viewModel.didSelectType(type)
            }).disposed(by: bag)
        
    }
    
    

}

extension HomeRootView : WaterfallLayoutDataSource {
    func waterfallLayout(_ layout : WaterfallLayout, indexPath : IndexPath) -> CGFloat {
        switch dataSource[indexPath] {
        case .postMoment(let data):
            return data.height
        }
    }
}



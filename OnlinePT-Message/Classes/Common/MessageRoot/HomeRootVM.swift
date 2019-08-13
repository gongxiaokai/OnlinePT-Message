//
//  PostMomentVM.swift
//  OnlinePT-Post
//
//  Created by gongwenkai on 2019/7/29.
//

import Foundation
import OnlinePT_BaseCore
import RxSwift
import RxDataSources
import RxCocoa
import Photos
import AMapLocationKit
import Kingfisher

public class HomeRootVM : BaseVM {
    struct Constant {
        static let margin = 10*kScale
        static let itemDefaultHeight = 100*kScale
        static let itemUserIconHeight = 30*kScale
        static let typeMargin = 100*kScale
        static let column = 2
    }

    
    public enum HomeType {
        /// 精选
        case featured
        /// 关注
        case followed
        /// 最新
        case newest
    }
    
    /// 查看动态详情
    public var momentDetailSubject = PublishSubject<Void>()

    /// 当前type
    public var currentTypeSubject = BehaviorSubject<HomeType>(value: .featured)


    var result : Observable<[HomeRootSection]>?
    private var loadData = PublishSubject<Void>()
    
    
    private var currentType : HomeType = .featured
    
    override init() {
        super.init()
        
//        let img = ImageDownloader.default
//        img.downloadImage(with: URL(string: "")!, options: []) { (img, url, data, error ) in
//
//        }
        
        let itemW = (kScreenW - Constant.margin - Constant.margin - Constant.margin * CGFloat(Constant.column - 1)) / CGFloat(Constant.column)
        
        let imageWidth = 100*kScale
        let imageHeight = 120*kScale
        let newImageHeight = imageHeight / imageWidth * itemW
        let newImageWidth = itemW
        
        
        
        
        
        result = loadData.flatMap{ ()  -> Observable<[HomeRootSection]> in
            return Observable<[HomeRootSection]>.just([
                HomeRootSection(header: "homeRoot", items: [
                    .postMoment(url: "1",
                                height: CGFloat.random(in: 200...300) + CGFloat(100),
                                title: "123",
                                userIcon: "123",
                                userName: "123",
                                isLike: true,
                                likeCount: "22"),
                    .postMoment(url: "1",
                                height: CGFloat.random(in: 200...300) + CGFloat(100),
                                title: "123",
                                userIcon: "123",
                                userName: "123",
                                isLike: true,
                                likeCount: "22"),
                    .postMoment(url: "1",
                                height: CGFloat.random(in: 200...300) + CGFloat(100),
                                title: "123",
                                userIcon: "123",
                                userName: "123",
                                isLike: true,
                                likeCount: "22"),
                    .postMoment(url: "1",
                                height: CGFloat.random(in: 200...300) + CGFloat(100),
                                title: "123",
                                userIcon: "123",
                                userName: "123",
                                isLike: true,
                                likeCount: "22"),

                    
                    
                    ])
                ])
        }
    }
    
    func fetchData(_ type : HomeType = HomeType.featured) {
        currentTypeSubject.onNext(type)
        loadData.onNext(())
    }
    
    
    func didSelectType(_ type: HomeRootSectionType) {
        self.momentDetailSubject.onNext(())
    }
    
}

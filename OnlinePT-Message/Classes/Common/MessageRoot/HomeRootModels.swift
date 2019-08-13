//
//  PostMomentModels.swift
//  OnlinePT-Post
//
//  Created by gongwenkai on 2019/7/29.
//

import Foundation
import ObjectMapper
import RxDataSources



enum HomeRootSectionType : IdentifiableType,Equatable{
    typealias Identity = String
    
    /// 动态
    case postMoment(
        url: String,
        height: CGFloat,
        title: String,
        userIcon: String,
        userName: String,
        isLike: Bool,
        likeCount:String)
    
    static func == (lhs: HomeRootSectionType, rhs: HomeRootSectionType) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    var identity : Identity {
        switch self {
        case .postMoment(let data):
            return data.url + data.title
        }
    }
}


//自定义Section
struct HomeRootSection {
    var header: String
    var items: [Item]
}

extension HomeRootSection : AnimatableSectionModelType {
    typealias Item = HomeRootSectionType
    
    
    var identity: String {
        return header
    }
    
    
    init(original: HomeRootSection, items: [Item]) {
        self = original
        self.items = items
    }
}

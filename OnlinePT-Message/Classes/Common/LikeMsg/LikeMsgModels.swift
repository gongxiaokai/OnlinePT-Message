//
//  LikeMsgModels.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import ObjectMapper
import RxDataSources
import OnlinePT_BaseCore
import OnlinePT_Config

enum LikeMsgSectionType : IdentifiableType,Equatable{
    typealias Identity = String
    
    case item(
        id: String,
        name: String,
        avatar: String,
        date: String,
        content: String,
        imageUrl: String,
        isVideo: Bool)
    
    static func == (lhs: LikeMsgSectionType, rhs: LikeMsgSectionType) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    var identity : Identity {
        switch self {
        case .item(let data):
            return data.id + data.name + data.avatar + data.date + data.imageUrl + "\(data.isVideo)" + data.content
        }
    }
}


//自定义Section
struct LikeMsgSection {
    var header: String
    var items: [Item]
}

extension LikeMsgSection : AnimatableSectionModelType {
    typealias Item = LikeMsgSectionType
    
    
    var identity: String {
        return header
    }
    
    
    init(original: LikeMsgSection, items: [Item]) {
        self = original
        self.items = items
    }
}

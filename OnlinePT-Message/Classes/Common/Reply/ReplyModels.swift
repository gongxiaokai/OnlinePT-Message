//
//  ReplyModels.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import ObjectMapper
import RxDataSources
import OnlinePT_BaseCore
import OnlinePT_Config

enum ReplySectionType : IdentifiableType,Equatable{
    typealias Identity = String
    
    case followed(id: String, name: String, avatar: String, gender: GenderType, relationType: RelationType)
    
    static func == (lhs: ReplySectionType, rhs: ReplySectionType) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    var identity : Identity {
        switch self {
        case .followed(let data):
            return data.id + data.name + data.avatar + "\(data.gender.rawValue)" + "\(data.relationType.rawValue)"
        }
    }
}


//自定义Section
struct ReplySection {
    var header: String
    var items: [Item]
}

extension ReplySection : AnimatableSectionModelType {
    typealias Item = ReplySectionType
    
    
    var identity: String {
        return header
    }
    
    
    init(original: ReplySection, items: [Item]) {
        self = original
        self.items = items
    }
}


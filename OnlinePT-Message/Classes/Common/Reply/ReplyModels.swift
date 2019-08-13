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
    
    case info(imageUrl: String, content: String, date: String)
    case comment(id: String, name: String, profile: String, toReply: String, content: String, date: String)

    static func == (lhs: ReplySectionType, rhs: ReplySectionType) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    var identity : Identity {
        switch self {
        case .info(let data):
            return data.imageUrl + data.content + data.date
        case .comment(let data):
            return data.id +
            data.name +
            data.profile +
            data.toReply +
            data.content +
            data.date
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


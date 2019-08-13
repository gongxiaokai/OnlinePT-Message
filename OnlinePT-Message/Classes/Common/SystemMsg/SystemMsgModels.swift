//
//  SystemMsgModels.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/13.
//

import Foundation
import ObjectMapper
import RxDataSources
import OnlinePT_BaseCore
import OnlinePT_Config


/// sectionType 示例
enum SystemMsgSectionType : IdentifiableType,Equatable{
    typealias Identity = String
    
    case msg(id: String, type: String, content: String, date: String)
    
    static func == (lhs: SystemMsgSectionType, rhs: SystemMsgSectionType) -> Bool {
        return lhs.identity == rhs.identity
    }
    
    var identity : Identity {
        switch self {
        case .msg(let data):
            return data.id + data.type + data.content + data.date
        }
    }
}


//自定义Section
struct SystemMsgSection {
    var header: String
    var items: [Item]
}

extension SystemMsgSection : AnimatableSectionModelType {
    typealias Item = SystemMsgSectionType
    
    
    var identity: String {
        return header
    }
    
    
    init(original: SystemMsgSection, items: [Item]) {
        self = original
        self.items = items
    }
}


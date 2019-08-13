//
//  ReplyVM.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config
import RxCocoa
import RxSwift
import RxDataSources


class ReplyVM : BaseVM {
    struct Constant {
        static let margin = 10*kScale
        static let itemInfoImageHeight = 80*kScale
        static let itemInfoHeight = 110*kScale
        static let itemUserIconHeight = 30*kScale
        static let commentSendWidth = 50*kScale
        static let commentViewHeight = 75*kScale
    }
    
    
    /// tableView 点击
    public var tableDidSelectedSubject = PublishSubject<ReplySectionType>()
    
    
    /// 回复某人
    public var replyToUserSubject = PublishSubject<(id:String,name:String)>()
    
    /// 发送评论
    public var commentSubject = PublishSubject<(userId: String,content: String)>()

    
    public var result : Observable<[ReplySection]>?
    private var loadData = PublishSubject<Void>()
    
    override init() {
        super.init()
        result = loadData.flatMap{ [unowned self] () -> Observable<[ReplySection]> in
            let randomSection = self.buildMockData()
            return  Observable<[ReplySection]>.just(randomSection)
        }
        
        tableDidSelectedSubject
            .subscribe(onNext: { [unowned self] (type) in
                self.tableDidSelected(type)
            }).disposed(by: bag)
        
        
        commentSubject.subscribe(onNext: { (id, content) in
            logger.debug("id = \(id),content = \(content)")
        }).disposed(by: bag)
        
    }
    
    func fetchData() {
        loadData.onNext(())
    }
}

extension ReplyVM {
    private func tableDidSelected(_ type: ReplySectionType) {
        switch type {
        case .comment(let data):
            self.replyToUserSubject.onNext((id: data.id, name: data.name))
        default: break
        }
    }
    
    private func buildMockData() -> [ReplySection] {
        let infoItme = ReplySectionType.info(imageUrl: "", content: "了肯定法轮大法", date: "2010-10-10")
        
        let commentItems : [ReplySectionType] = (0..<10).map{
            ReplySectionType.comment(
                id: "\($0)",
                name: (0..<(1..<10).randomElement()!).reduce("", { "\($0)" + "\($1)"}),
                profile: "\($0)",
                toReply: "\($0)",
                content: (0..<(1..<80).randomElement()!).reduce("", { "\($0)" + "\($1)"}),
                date: "201\($0)-10-2\($0)")
        }
        let sections = [
            ReplySection(header: "info", items: [infoItme]),
            ReplySection(header: "comments", items: commentItems)
        ]
        return sections
    }
}

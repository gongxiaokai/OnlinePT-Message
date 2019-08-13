//
//  LikeMsgVM.swift
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


class LikeMsgVM : BaseVM {
    struct Constant {
        static let margin = 10*kScale
        static let itemUserIconHeight = 45*kScale
        static let itemHeight = 70*kScale

    }
    
    /// tableView 点击
    public var tableDidSelectedSubject = PublishSubject<LikeMsgSectionType>()
    
    
    /// 点击评论快捷回复
    public var tapReplySubject = PublishSubject<String>()
    
    
    public var result : Observable<[LikeMsgSection]>?
    private var loadData = PublishSubject<Void>()
    
    override init() {
        super.init()
        result = loadData.flatMap{ [unowned self] () -> Observable<[LikeMsgSection]> in
            let randomItem = self.buildMockData()
            return  Observable<[LikeMsgSection]>.just([
                LikeMsgSection(header: "followed", items: randomItem),
                ])
        }
        
        tableDidSelectedSubject
            .subscribe(onNext: { [unowned self] (type) in
                self.tableDidSelected(type)
            }).disposed(by: bag)
    }
    
    func fetchData() {
        loadData.onNext(())
    }
}

extension LikeMsgVM {
    private func tableDidSelected(_ type: LikeMsgSectionType) {
        switch type {
        case .item(let data):
            self.tapReplySubject.onNext(data.id)
        default: break
        }
    }
    
    private func buildMockData() -> [LikeMsgSectionType] {
        let randomItem : [LikeMsgSectionType] = (0..<10).map{
            .item(id: "\($0)",
                name: "\($0)",
                avatar: "\($0)",
                date: "\($0)",
                content : (0..<(1..<100).randomElement()!).reduce("", { "\($0)" + "\($1)"}),
                imageUrl: "\($0)",
                isVideo: [true,false].randomElement()!)
        }
        return randomItem
    }
}

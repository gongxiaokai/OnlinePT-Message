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
        static let itemUserIconHeight = 45*kScale
    }
    
    
    /// tableView 点击
    public var tableDidSelectedSubject = PublishSubject<ReplySectionType>()
    
    
    public var result : Observable<[ReplySection]>?
    private var loadData = PublishSubject<Void>()
    
    override init() {
        result = loadData.flatMap{ () -> Observable<[ReplySection]> in
            let randomItem : [ReplySectionType] = (0..<10).map{
                .followed(
                    id: "\($0)",
                    name: "\($0)",
                    avatar: "\($0)",
                    gender: .female,
                    relationType: .followed)
            }
            return  Observable<[ReplySection]>.just([
                ReplySection(header: "followed", items: randomItem),
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

extension ReplyVM {
    private func tableDidSelected(_ type: ReplySectionType) {
        switch type {
        default: break
        }
    }
}

//
//  SystemMsgVM.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/13.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config
import RxCocoa
import RxSwift
import RxDataSources

/// vm 示例
class SystemMsgVM : BaseVM {
    struct Constant {
        static let margin = 10*kScale
        static let itemUserIconHeight = 50*kScale
        static let itemHeight = 87*kScale
    }
    
    
    /// tableView 点击
    public var tableDidSelectedSubject = PublishSubject<SystemMsgSectionType>()
    
    
    public var result : Observable<[SystemMsgSection]>?
    private var loadData = PublishSubject<Void>()
    
    override init() {
        super.init()
        result = loadData.flatMap{ [unowned self] () -> Observable<[SystemMsgSection]> in
            let randomSections = self.buildMockData()
            return  Observable<[SystemMsgSection]>.just(randomSections)
        }
        
        
        tableDidSelectedSubject
            .subscribe(onNext: { [unowned self] (type) in
                self.tableDidSelected(type)
            }).disposed(by: bag)
    }
    
    public func fetchData() {
        loadData.onNext(())
    }
}

//MARK: 私有方法
extension SystemMsgVM {
    private func tableDidSelected(_ type: SystemMsgSectionType) {
        switch type {
        default: break
        }
    }
    
    private func buildMockData() -> [SystemMsgSection] {
        let randomItem : [SystemMsgSectionType] = (0..<10).map{
            SystemMsgSectionType.msg(
                id: "\($0)",
                type: "\($0)",
                content: (0..<(1..<100).randomElement()!).reduce("", { "\($0)" + "\($1)"}),
                date: "2010-1\($0)-1\($0)")
        }
        
        let sections = [
            SystemMsgSection(header: "systemMsg", items: randomItem),
        ]
        return sections
    }
    
}

//
//  MessageApi.swift
//  OnlinePT-Home
//
//  Created by gongwenkai on 2019/8/8.
//

import Foundation
import OnlinePT_Config
import Moya



let messageApiProvider = MoyaProvider<MessageApi>()

enum MessageApi {
    enum LikeStateType :Int{
        case like       = 1
        case unlike     = 0
    }
    
    enum FavStateType :Int{
        case fav       = 1
        case unfav     = 0
    }
    
    enum FollowStateType :Int{
        case follow       = 1
        case unfollow     = 0
    }
    
    /// 点赞 是否点赞（0：取消点赞，1：点赞）
    case like(
        dynamicStateId: String,
        like: LikeStateType)
    
    /// 收藏 是否收藏（0：取消收藏，1：收藏）
    case fav(
        dynamicStateId: String,
        collect: FavStateType)
    
    /// 关注   操作状态（0：取关，1：关注）
    case follow(
        friendId: String,
        focus: FollowStateType)
    
    /// 回复评论 （toUserId = dynamicStateId 是为回复本动态）
    case comment(
        toUserId: String,
        dynamicStateId: String,
        content: String)
    
}

extension MessageApi : TargetType {
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var baseURL: URL {
        return URL(string: Envs.baseUrl + "/api/online-community")!
    }
    
    var path: String {
        switch self {
        case .follow:
            return "userRelationship/focus"
        case .like:
            return "/myLike/like"
        case .fav:
            return "/myCollect/collect"
        case .comment:
            return "/comment/replyComment"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .fav,
             .follow,
             .like,
             .comment:
            return .post
        }
    }
    
    var task: Task {
        switch self {
        case .follow(let friendId, let focus):
            let params : [String : Any] = [
                "friendId"          :friendId,
                "focus"             :focus.rawValue
            ]
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)

        case .like(let dynamicStateId, let like):
            let params : [String : Any] = [
                "dynamicStateId"     :dynamicStateId,
                "like"               :like.rawValue
            ]
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .fav(let dynamicStateId, let collect):
            let params : [String : Any] = [
                "dynamicStateId"     :dynamicStateId,
                "collect"            :collect.rawValue
            ]
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        case .comment(let toUserId, let dynamicStateId, let content):
            let params : [String : String] = [
                "toUserId"           :toUserId,
                "dynamicStateId"     :dynamicStateId,
                "content"            :content
            ]
            return Task.requestParameters(parameters: params, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .like,
             .follow,
             .comment,
             .fav:
            return Global.shared.header
        }
    }
}

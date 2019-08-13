

import Foundation
import URLNavigator
import EachNavigationBar
import OnlinePT_BaseCore
import OnlinePT_Config

public struct MessageRouter {
    public static func initialize(navigator: NavigatorType) {
//        /// postHome
//        navigator.register("HomeRoot".formatScheme()) { url, values ,context in
//            let vc = HomeRootVC()
//            let nav = UINavigationController(rootViewController: vc)
//            nav.modalPresentationStyle = .custom
//            let back = BackBarButtonItem(style: .image(UIImage(named: "nav_back_white", in: BaseCore.bundle, compatibleWith: nil)), tintColor: .white)
//            nav.navigation.configuration.isEnabled = true
//            nav.navigation.configuration.tintColor = .white
//            nav.navigation.configuration.titleTextAttributes =  [
//                NSAttributedString.Key.foregroundColor : Theme.main.white,
//                NSAttributedString.Key.font : UIFont.navTitleFont]
//            nav.navigation.configuration.alpha = 0
//            nav.navigation.configuration.backBarButtonItem = back
//            return nav
//        }
      
        
        
        
        /// 点赞和评论消息
        navigator.register("likeMsg".formatScheme()) { url, values ,context in
            let vc = LikeMsgVC()
            vc.hidesBottomBarWhenPushed = true
            return vc
        }
        /// 系统消息
        navigator.register("systemMsg".formatScheme()) { url, values ,context in
            let vc = SystemMsgVC()
            vc.hidesBottomBarWhenPushed = true
            return vc
        }
        
        /// 快捷回复
        navigator.register("reply".formatScheme()) { url, values ,context in
            let vc = ReplyVC()
            vc.hidesBottomBarWhenPushed = true
            return vc
        }
        
        
//        /// 弹出框 选择方式
//        navigator.handle("postMoment/from".formatScheme()){ url, values ,context in
////            let title = url.queryParameters["title"]
////            let message = url.queryParameters["message"]
////            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
////            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//
//
//
//            let alertController = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
//            let takePhotoAction = UIAlertAction(title: "拍照或拍摄", style: .default, handler: { _ in
////                self.takePhoto()
//            })
//            alertController.addAction(takePhotoAction)
//
//            let selectFromAlbumAction = UIAlertAction(title: "相册", style: .default, handler: { _ in
//
//            })
//            alertController.addAction(selectFromAlbumAction)
//
//            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
//            alertController.addAction(cancelAction)
////            self.present(alertController, animated: true, completion: nil)
//            navigator.present(alertController)
//            return true
//        }
        
    }
    
}

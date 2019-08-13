



import EachNavigationBar
import OnlinePT_BaseCore
import OnlinePT_Config
/// 本模块的名称， 本模块的storyboard 名称必须 与模块名称相同 ,已经用于静态资源的加载回用到
let modularName = "OnlinePT-Message"

public class MessageCore {
    public static var sharedInstance :  MessageCore {
        struct Static {
            static let instance :  MessageCore =  MessageCore()
        }
        return Static.instance
    }
    
    ///供其他模块使用
    public static var bundle:Bundle?{
        get{
            guard let bundleURL = Bundle(for: MessageCore.self).url(forResource: modularName, withExtension: "bundle") else {
                return nil
            }
            guard let bundle = Bundle(url: bundleURL) else {
                return nil
            }
            return bundle
        }
    }

    /// 外部调用模块
    public static var messageNav : UINavigationController {
        let back = BackBarButtonItem(style: .image(UIImage(named: "nav_back_white", in: BaseCore.bundle, compatibleWith: nil)), tintColor: .white)
        let mineVc = MessageRootVC()
        let mineNav = UINavigationController(rootViewController: mineVc)
        mineNav.navigation.configuration.isEnabled = true
        mineNav.navigation.configuration.isTranslucent = false
        mineNav.navigation.configuration.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor : Theme.main.white,
            NSAttributedString.Key.font : UIFont.navTitleFont]
        mineNav.navigation.configuration.backBarButtonItem = back
        return mineNav
    }
}



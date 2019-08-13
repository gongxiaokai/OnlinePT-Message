//
//  SystemMsgCell.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/13.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config

/// cell 示例
class SystemMsgCell: NiblessTableViewCell {
    public var msgType: String = "" {
        didSet {
            
        }
    }
    
    public var date: String = "" {
        didSet {
            dateLabel.text = date
        }
    }
    
    public var content: String = "" {
        didSet {
            contentLabel.text = content
        }
    }
    
 
    private lazy var contentLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 16)
        lab.textColor = Theme.main.baseTitle
        lab.numberOfLines = 0
        return lab
    }()
    private lazy var dateLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.light, size: 12)
        lab.textColor = Theme.main.baseText
        return lab
    }()
    
    private lazy var typeImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    
    private lazy var arrowImgView = UIImageView(image: UIImage(named: "arrow_right_red",
                                                   in: BaseCore.bundle,
                                                   compatibleWith: nil))
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.makeRoundedCorners(5)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        setupLayout()
        bindViewModel()
    }
    
}


extension SystemMsgCell : ViewBaseProtocol {
    internal func setupStyle() {
        contentView.addSubview(bgView)
        bgView.addSubview(contentLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(typeImageView)
        bgView.addSubview(arrowImgView)
    }
    
    internal func setupLayout() {
        bgView.snp.makeConstraints{
            $0.top.equalTo(SystemMsgVM.Constant.margin/2).priority(.low)
            $0.bottom.equalTo(-SystemMsgVM.Constant.margin/2).priority(.low)
            $0.height.equalTo(SystemMsgVM.Constant.itemHeight).priority(.high)
            $0.left.right.equalToSuperview().priority(.high)
//            $0.width.equalToSuperview().priority(.high)
        }
        
        typeImageView.snp.makeConstraints{
            $0.top.equalToSuperview()
            $0.left.equalTo(SystemMsgVM.Constant.margin)
            $0.width.equalTo(2*SystemMsgVM.Constant.margin)
            $0.height.equalTo(4*SystemMsgVM.Constant.margin)
        }

        contentLabel.snp.makeConstraints{
            $0.top.equalTo(SystemMsgVM.Constant.margin)
            $0.left.equalTo(typeImageView.snp.right).offset(SystemMsgVM.Constant.margin).priority(.high)
            $0.right.equalTo(-3*SystemMsgVM.Constant.margin).priority(.high)
            $0.width.equalTo(SystemMsgVM.Constant.margin).priority(.low)
            $0.bottom.lessThanOrEqualTo(dateLabel.snp.top)
        }

        dateLabel.snp.makeConstraints{
            $0.bottom.equalTo(-SystemMsgVM.Constant.margin)
            $0.left.equalTo(typeImageView.snp.right).offset(SystemMsgVM.Constant.margin)
            $0.height.equalTo(2*SystemMsgVM.Constant.margin).priority(.high)
        }

        arrowImgView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.right.equalTo(-SystemMsgVM.Constant.margin)
        }
    }
    
    internal func bindViewModel() {
        
    }
    
    
}

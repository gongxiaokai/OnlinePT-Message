//
//  ReplyCommentCell.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config

/// cell 示例
class ReplyCommentCell: NiblessTableViewCell {
    
    public var title: String = ""{
        didSet {
            titleLabel.text = title
        }
    }
    
    public var icon: String = ""{
        didSet {
        }
    }
    
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        let width = ExampleVM.Constant.itemUserIconHeight
        view.contentMode = UIView.ContentMode.scaleAspectFill
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: width),
                                byRoundingCorners: [.topLeft,.topRight,.bottomLeft,.bottomRight],
                                cornerRadii: CGSize(width: width/2, height: width/2))
        let shapLayer = CAShapeLayer()
        shapLayer.lineWidth = 4
        shapLayer.strokeColor = Theme.main.baseRed.cgColor
        shapLayer.fillColor = UIColor.clear.cgColor
        shapLayer.path = path.cgPath
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        view.layer.mask = maskLayer
        view.layer.addSublayer(shapLayer)
        return view
    }()
    
    private lazy var titleLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 16)
        lab.textColor = Theme.main.baseRed
        return lab
    }()
    
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


extension ReplyCommentCell : ViewBaseProtocol {
    internal func setupStyle() {
        contentView.addSubview(bgView)
        bgView.addSubview(profileImageView)
        bgView.addSubview(titleLabel)
    }
    
    internal func setupLayout() {
        bgView.snp.makeConstraints{
            $0.left.top.equalTo(ExampleVM.Constant.margin).priority(.low)
            $0.right.bottom.equalTo(-ExampleVM.Constant.margin).priority(.low)
            $0.height.equalTo(5*ExampleVM.Constant.margin).priority(.high)
        }
        
        
        profileImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(ExampleVM.Constant.margin)
            $0.width.height.equalTo(ExampleVM.Constant.itemUserIconHeight)
        }
        
        titleLabel.snp.makeConstraints{
            $0.bottom.equalTo(bgView.snp.centerY)
            $0.left.equalTo(50*kScale)
            $0.height.equalTo(44*kScale)
        }
        
    }
    
    internal func bindViewModel() {
        
    }
    
    
}


//
//  ReplyCommentCell.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config

/// cell 示例
class ReplyCommentCell: NiblessTableViewCell {
      
    public var content: String = ""{
        didSet {
            contentLabel.text = content
        }
    }
    
    public var date: String = ""{
        didSet {
            dateLabel.text = date
        }
    }
    
    public var fromName: String = ""{
        didSet {
            fromNameLabel.text = fromName
        }
    }
    
    public var toName: String = ""{
        didSet {
            toNameLabel.text = toName
        }
    }
    
    public var profile: String = ""{
        didSet {
//            profileImageView.kf.setFadeImage(with: URL(string: profile))
        }
    }
    
    
    private lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        let width = ReplyVM.Constant.itemUserIconHeight
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
    
    private lazy var contentLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 16)
        lab.textColor = Theme.main.baseText
        lab.numberOfLines = 0
        return lab
    }()
    
    private lazy var fromNameLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 13)
        lab.textColor = Theme.main.baseRed
        return lab
    }()
    
    private lazy var replyLabel : UILabel = {
        let lab = UILabel()
        lab.text = "回复"
        lab.fontSize(Theme.font.normal, size: 10)
        lab.textColor = Theme.main.baseText
        return lab
    }()
    
    private lazy var toNameLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 13)
        lab.textColor = Theme.main.baseRed
        return lab
    }()
    
    private lazy var dateLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 16)
        lab.textColor = Theme.main.baseText
        return lab
    }()
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        setupLayout()
        bindViewModel()
    }
    
}


extension ReplyCommentCell : ViewBaseProtocol {
    internal func setupStyle() {
        contentView.addSubview(bgView)
        bgView.addSubview(profileImageView)
        bgView.addSubview(fromNameLabel)
        bgView.addSubview(replyLabel)
        bgView.addSubview(toNameLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(contentLabel)
    }
    
    internal func setupLayout() {
        bgView.snp.makeConstraints{
            $0.left.top.equalToSuperview().priority(.low)
            $0.right.bottom.equalToSuperview().priority(.low)
            $0.width.equalToSuperview().priority(.high)
        }
        
        
        profileImageView.snp.makeConstraints{
            $0.top.equalTo(ReplyVM.Constant.margin)
            $0.left.equalTo(3*ReplyVM.Constant.margin)
            $0.width.height.equalTo(ReplyVM.Constant.itemUserIconHeight)
        }
        
        contentLabel.snp.makeConstraints{
            $0.top.equalTo(fromNameLabel.snp.bottom)
            $0.left.equalTo(fromNameLabel)
            $0.right.equalTo(-3*ReplyVM.Constant.margin)
            $0.bottom.equalTo(-ReplyVM.Constant.margin).priority(.high)
        }
        
        fromNameLabel.snp.makeConstraints{
            $0.top.equalTo(profileImageView)
            $0.left.equalTo(profileImageView.snp.right).offset(ReplyVM.Constant.margin)
            $0.width.lessThanOrEqualTo(10*ReplyVM.Constant.margin)
        }
        
        replyLabel.snp.makeConstraints{
            $0.centerY.equalTo(fromNameLabel)
            $0.left.equalTo(fromNameLabel.snp.right).offset(ReplyVM.Constant.margin/2)
            $0.width.lessThanOrEqualTo(10*ReplyVM.Constant.margin)
        }
        
        toNameLabel.snp.makeConstraints{
            $0.centerY.equalTo(fromNameLabel)
            $0.left.equalTo(replyLabel.snp.right).offset(ReplyVM.Constant.margin/2)
        }
        
        
        
        dateLabel.snp.makeConstraints{
            $0.centerY.equalTo(fromNameLabel)
            $0.right.equalTo(-3*ReplyVM.Constant.margin)
        }
        
    }
    
    internal func bindViewModel() {
        
    }
    
    
}


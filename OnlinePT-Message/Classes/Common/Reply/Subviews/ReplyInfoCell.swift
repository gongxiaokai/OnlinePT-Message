//
//  ReplyInfoCell.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config

/// cell 示例
class ReplyInfoCell : NiblessTableViewCell {
    
    var imageUrl: String = ""{
        didSet {
//            momentImageView.kf.setFadeImage(with: URL(string: imageUrl))
        }
    }
    
    var date: String = "" {
        didSet {
            dateLabel.text = date
        }
    }
    
    var content: String = "" {
        didSet {
            contentLabel.text = content
        }
    }
    
    
    
    private lazy var momentImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        view.contentMode = UIView.ContentMode.scaleAspectFill
        let width = ReplyVM.Constant.itemInfoImageHeight
        let path = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: width, height: width),
                                byRoundingCorners: [.topLeft,.topRight,.bottomLeft,.bottomRight],
                                cornerRadii: CGSize(width: ReplyVM.Constant.margin,
                                                    height:ReplyVM.Constant.margin))
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
        lab.textColor = Theme.main.baseRed
        return lab
    }()
    
    private lazy var dateLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 16)
        lab.textColor = Theme.main.baseRed
        return lab
    }()
    
    private lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
//        view.makeRoundedCorners(5)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupStyle()
        setupLayout()
        bindViewModel()
    }
    
}

extension ReplyInfoCell : ViewBaseProtocol {
    internal func setupStyle() {
        contentView.addSubview(bgView)
        bgView.addSubview(momentImageView)
        bgView.addSubview(contentLabel)
        bgView.addSubview(dateLabel)
    }
    
    internal func setupLayout() {
        bgView.snp.makeConstraints{
            $0.left.top.equalToSuperview()
            $0.right.bottom.equalToSuperview()
            $0.height.equalTo(ReplyVM.Constant.itemInfoHeight).priority(.high)
        }
        
        momentImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(ReplyVM.Constant.margin)
            $0.width.height.equalTo(ReplyVM.Constant.itemInfoImageHeight)
        }
        
        dateLabel.snp.makeConstraints{
            $0.bottom.equalTo(momentImageView)
            $0.right.equalTo(-2*ReplyVM.Constant.margin)
        }
        
        contentLabel.snp.makeConstraints{
            $0.top.equalTo(momentImageView)
            $0.left.equalTo(momentImageView.snp.right).offset(ReplyVM.Constant.margin)
            $0.right.equalTo(-2*ReplyVM.Constant.margin)
            $0.bottom.lessThanOrEqualTo(dateLabel.snp.top).offset(-ReplyVM.Constant.margin)
        }
        
    }
    
    internal func bindViewModel() {
        
    }
    
    
}


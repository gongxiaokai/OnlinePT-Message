//
//  LikeMsgCell.swift
//  OnlinePT-Message
//
//  Created by gongwenkai on 2019/8/12.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config

class LikeMsgCell: NiblessTableViewCell {
    
    var name: String = ""{
        didSet {
            nameLabel.text = name
        }
    }
    
    var profile: String = ""{
        didSet {
            profileImageView.kf.setFadeImage(with: URL(string: profile)!)
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
    
    var imageUrl: String = "" {
        didSet {
            thumbImageView.kf.setFadeImage(with: URL(string: imageUrl))
        }
    }
    
    var isVideo : Bool = false {
        didSet {
            playImageView.isHidden = !isVideo
        }
    }
    
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        view.contentMode = UIView.ContentMode.scaleAspectFill
        let width = LikeMsgVM.Constant.itemUserIconHeight
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
    
    private lazy var nameLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 17)
        lab.textColor = Theme.main.baseRed
        return lab
    }()
    
    private lazy var dateLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.light, size: 12)
        lab.textColor = Theme.main.baseTitle
        return lab
    }()
    
    private lazy var contentLabel : UILabel = {
        let lab = UILabel()
        lab.fontSize(Theme.font.normal, size: 14)
        lab.textColor = Theme.main.baseTitle
        return lab
    }()
    
    lazy var playImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        view.image = UIImage(named: "play", in: MessageCore.bundle, compatibleWith: nil)
        return view
    }()
    
    
    private lazy var thumbImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        view.contentMode = UIView.ContentMode.scaleAspectFill
        let width = LikeMsgVM.Constant.itemUserIconHeight
        return view
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

extension LikeMsgCell : ViewBaseProtocol {
    func setupStyle() {
        contentView.addSubview(bgView)
        bgView.addSubview(profileImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(dateLabel)
        bgView.addSubview(contentLabel)
        bgView.addSubview(thumbImageView)
        thumbImageView.addSubview(playImageView)
    }
    
    func setupLayout() {
        bgView.snp.makeConstraints{
            $0.top.equalTo(LikeMsgVM.Constant.margin/2).priority(.low)
            $0.bottom.equalTo(-LikeMsgVM.Constant.margin/2).priority(.low)
            $0.height.equalTo(LikeMsgVM.Constant.itemHeight).priority(.high)
            $0.left.right.equalToSuperview().priority(.high)
        }
        
        
        profileImageView.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.left.equalTo(LikeMsgVM.Constant.margin)
            $0.width.height.equalTo(LikeMsgVM.Constant.itemUserIconHeight)
        }
        
        nameLabel.snp.makeConstraints{
            $0.bottom.equalTo(profileImageView.snp.centerY)
            $0.left.equalTo(profileImageView.snp.right).offset(LikeMsgVM.Constant.margin)
        }
        
        contentLabel.snp.makeConstraints{
            $0.top.equalTo(profileImageView.snp.centerY)
            $0.left.equalTo(profileImageView.snp.right).offset(LikeMsgVM.Constant.margin).priority(.high)
            $0.right.equalTo(thumbImageView.snp.left).offset(-LikeMsgVM.Constant.margin).priority(.high)
            $0.width.equalTo(LikeMsgVM.Constant.margin).priority(.low)
        }
        
        dateLabel.snp.makeConstraints{
            $0.bottom.equalTo(nameLabel)
            $0.left.equalTo(bgView.snp.centerX)
        }
        
        thumbImageView.snp.makeConstraints{
            $0.right.equalTo(-LikeMsgVM.Constant.margin)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(6*LikeMsgVM.Constant.margin)
        }
        
        playImageView.snp.makeConstraints{
            $0.center.equalToSuperview()
            $0.width.height.equalTo(2*LikeMsgVM.Constant.margin)
        }
        
    }
    
    func bindViewModel() {
        
    }
    
    
}


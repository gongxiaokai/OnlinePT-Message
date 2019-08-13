//
//  PostMomentPhotosCell.swift
//  OnlinePT-Post
//
//  Created by gongwenkai on 2019/7/30.
//

import Foundation
import OnlinePT_BaseCore
import OnlinePT_Config
import SnapKit
class HomeRootCell: NiblessCollectionViewCell {
    
    var cellHeight: CGFloat = 100 {
        didSet {
            self.heightCons?.update(offset: cellHeight - 100)
        }
    }
    
    var urlStr: String = "" {
        didSet {
            self.imageView.kf.setFadeImage(with: URL(string: urlStr))
        }
    }
    
    
    private var heightCons : Constraint?
    
    lazy var bgView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    lazy var likeBtn: UIButton = {
        let btn = UIButton()
        btn.setImage(UIImage(named: "like_normal", in: BaseCore.bundle, compatibleWith: nil), for: .normal)
        return btn
    }()
    
    lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.backgroundColor = .random
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    
    lazy var profileImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .random
        view.contentMode = UIView.ContentMode.scaleAspectFill
        let width = HomeRootVM.Constant.itemUserIconHeight
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
    
    lazy var titleLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = Theme.main.baseTitle
        lab.numberOfLines = 0
        lab.text = "暴瘦全身最有效的全部动作啊啊啊啊啊啊"
        lab.fontSize(Theme.font.bold, size: 20)
        return lab
    }()
    
    lazy var nameLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = Theme.main.baseRed
        lab.text = "JACs江苏水电发是是"
        lab.fontSize(Theme.font.normal, size: 14)
        return lab
    }()
    
    lazy var countLabel: UILabel = {
        let lab = UILabel()
        lab.textColor = Theme.main.baseText
        lab.text = "2万"
        lab.fontSize(Theme.font.normal, size: 10)
        return lab
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStyle()
        setupLayout()
        bindViewModel()
    }

}

extension HomeRootCell : ViewBaseProtocol {
    func setupStyle() {
        contentView.addSubview(bgView)
        contentView.addSubview(imageView)
        contentView.addSubview(likeBtn)
        contentView.addSubview(titleLabel)
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(countLabel)
        
    }
    
    func setupLayout() {
//        let random = CGFloat.random(in: CGFloat(20.0)...CGFloat(120.0))
        
        bgView.snp.makeConstraints{
            $0.edges.equalToSuperview().priority(.low)
            $0.height.equalToSuperview().priority(.low)
            $0.width.equalToSuperview().priority(.high)
        }
        
        imageView.snp.makeConstraints{
            $0.top.left.right.equalToSuperview()
            self.heightCons = $0.height.equalTo(HomeRootVM.Constant.itemDefaultHeight).constraint
        }
        
        titleLabel.snp.makeConstraints{
            $0.left.equalTo(HomeRootVM.Constant.margin)
            $0.right.equalTo(-HomeRootVM.Constant.margin)
            $0.top.equalTo(imageView.snp.bottom).offset(HomeRootVM.Constant.margin)
//            $0.bottom.equalTo(-10*kScale).priority(.high)
        }
        
        likeBtn.snp.makeConstraints{
            $0.bottom.equalTo(countLabel)
            $0.right.equalTo(countLabel.snp.left).offset(-(HomeRootVM.Constant.margin / 2))
        }
        
        profileImageView.snp.makeConstraints{
            $0.left.equalTo(HomeRootVM.Constant.margin)
            $0.top.equalTo(titleLabel.snp.bottom).offset(HomeRootVM.Constant.margin)
            $0.width.height.equalTo(HomeRootVM.Constant.itemUserIconHeight)
            $0.bottom.equalTo(-HomeRootVM.Constant.margin).priority(.high)
        }
        
        
        nameLabel.snp.makeConstraints{
            $0.left.equalTo(profileImageView.snp.right).offset(HomeRootVM.Constant.margin)
            $0.centerY.equalTo(profileImageView)
            $0.width.lessThanOrEqualToSuperview().multipliedBy(0.4)
        }

        countLabel.snp.makeConstraints{
            $0.right.equalTo(-HomeRootVM.Constant.margin)
            $0.bottom.equalTo(nameLabel)
        }
    
    }

    func bindViewModel() {
        
    }
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        logger.severe("preferredLayoutAttributesFitting")
//        let frame = layoutAttributes.frame
//        layoutAttributes.frame = CGRect(x: frame.origin.x, y: frame.origin.y, width: frame.self.width, height: 800)
//        return layoutAttributes
//    }
   
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//        self.setNeedsLayout()
//        self.layoutIfNeeded()
//
//        let size = self.contentView.systemLayoutSizeFitting(layoutAttributes.size)
//        print("1size ====",size)
//        var cellFrame = layoutAttributes.frame
//        print("cellFrame ====",cellFrame)
//
//        cellFrame.size.height = size.height + 400*kScale
//        print("new cellFrame ====",cellFrame)
//
//        layoutAttributes.frame = cellFrame
//        return layoutAttributes
//    }
}

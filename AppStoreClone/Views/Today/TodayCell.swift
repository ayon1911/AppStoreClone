
//
//  TodayCell.swift
//  AppStoreClone
//
//  Created by krAyon on 03.03.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class TodayCell: UICollectionViewCell {
    
    var todayItem: TodayItem! {
        didSet {
            categoryLabel.text = todayItem.category
            titleLabel.text = todayItem.title
            descriptionLabel.text = todayItem.description
            imageView.image = todayItem.image
            backgroundColor = todayItem.backgrounColor
        }
    }
    
    var topConstraint: NSLayoutConstraint!
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "garden"))
    let categoryLabel = UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 20))
    let titleLabel = UILabel(text: "Utilizing", font: .boldSystemFont(ofSize: 28))
    let descriptionLabel = UILabel(text: "All the tools and apps you need to intelligently organize your life the right way", font: .systemFont(ofSize: 16), numberOfLines: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
        layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
        clipsToBounds = true
        
        let imageContainerView  = UIView()
        imageContainerView.addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 240, height: 240))
        
        let verticalStackView = VerticalStackView(arrangedSubViews: [categoryLabel, titleLabel, imageContainerView, descriptionLabel], spacing: 8)
        addSubview(verticalStackView)
        verticalStackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 24, left: 24, bottom: 24, right: 24))
        self.topConstraint = verticalStackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//
//  MultipleAppCell.swift
//  AppStoreClone
//
//  Created by krAyon on 16.03.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class MultipleAppCell: UICollectionViewCell {
    
    var app: FeedResult! {
        didSet {
            nameLable.text = app.name
            companyLabel.text = app.artistName
            imageView.sd_setImage(with: URL(string: app.artworkUrl100))
        }
    }
    
    let imageView = UIImageView(cornerradius: 8)
    let getButton = UIButton(title: "GET")
    let nameLable = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.3, alpha: 0.3)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        getButton.backgroundColor = UIColor.init(white: 0.95, alpha: 1)
        getButton.constrainWidth(constant: 80)
        getButton.constrainHeight(constant: 32)
        getButton.layer.cornerRadius = 32 / 2
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        
        imageView.constrainWidth(constant: 64)
        imageView.constrainHeight(constant: 64)
        imageView.backgroundColor = .purple
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView, VerticalStackView(arrangedSubViews: [nameLable, companyLabel], spacing: 4), getButton
            ])
        stackView.spacing = 16
        addSubview(stackView)
        stackView.alignment = .center
        stackView.fillSuperview()
        addSubview(separatorView)
        separatorView.anchor(top: nil, leading: nameLable.leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: -4, right: 0), size: .init(width: 0, height: 0.5))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

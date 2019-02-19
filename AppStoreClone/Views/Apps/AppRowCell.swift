//
//  AppRowCell.swift
//  AppStoreClone
//
//  Created by krAyon on 19.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit


class AppRowCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerradius: 8)
    let getButton = UIButton(title: "GET")
    let nameLable = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 20))
    let companyLabel = UILabel(text: "Company Name", font: .systemFont(ofSize: 13))
    
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
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

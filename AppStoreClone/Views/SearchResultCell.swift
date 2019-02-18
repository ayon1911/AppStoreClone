//
//  SearchResultCell.swift
//  AppStoreClone
//
//  Created by krAyon on 18.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class SearchResultCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
       let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    let nameLable: UILabel = {
        let label = UILabel()
        label.text = "App Name"
        return label
    }()
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Videos"
        return label
    }()
    let ratingsLabel: UILabel = {
        let label = UILabel()
        label.text = "9.267M"
        return label
    }()
    let getButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.backgroundColor = UIColor.init(white: 0.956, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 80).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenshot1ImgView = self.createScreenShotImageView()
    lazy var screenshot2ImgView = self.createScreenShotImageView()
    lazy var screenshot3ImgView = self.createScreenShotImageView()
    
    func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let infoTopStackView = UIStackView(arrangedSubviews: [
                appIconImageView,
                VerticalStackView(arrangedSubViews: [nameLable,categoryLabel,ratingsLabel]),
                getButton
            ])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center
        
        let screenShotsStackView = UIStackView(arrangedSubviews: [
                screenshot1ImgView,screenshot2ImgView,screenshot3ImgView
            ])
        screenShotsStackView.spacing = 12
        screenShotsStackView.distribution = .fillEqually
        
        let overallStackView = VerticalStackView(arrangedSubViews: [infoTopStackView, screenShotsStackView], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

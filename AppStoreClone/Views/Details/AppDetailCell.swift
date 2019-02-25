//
//  AppDetailCell.swift
//  AppStoreClone
//
//  Created by krAyon on 21.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class AppDetailCell: UICollectionViewCell {
    
    var app: Result! {
        didSet {
            nameLabel.text = app?.trackName
            releaseNoteslabel.text = app?.releaseNotes
            appIconImageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""), completed: nil)
            priceButton.setTitle(app?.formattedPrice, for: .normal)
        }
    }
    
    let appIconImageView = UIImageView(cornerradius: 16)
    let nameLabel = UILabel(text: "App Name", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let priceButton = UIButton(title: "$4.99")
    let whatsNewLabel = UILabel(text: "What's New", font: .boldSystemFont(ofSize: 20))
    let releaseNoteslabel = UILabel(text: "Release Notes Label", font: .systemFont(ofSize: 16), numberOfLines: 0)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        appIconImageView.backgroundColor = .red
        appIconImageView.constrainWidth(constant: 140)
        appIconImageView.constrainHeight(constant: 140)
        
        priceButton.backgroundColor = #colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1)
        priceButton.constrainHeight(constant: 32)
        priceButton.layer.cornerRadius = 32 / 2
        priceButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        priceButton.setTitleColor(.white, for: .normal)
        priceButton.constrainWidth(constant: 80)
        
        let stackView = VerticalStackView(arrangedSubViews: [UIStackView(arrangedSubviews: [appIconImageView, VerticalStackView(arrangedSubViews: [nameLabel, UIStackView(arrangedSubviews: [priceButton, UIView()]), UIView()], spacing: 12)], customSpacing: 20), whatsNewLabel, releaseNoteslabel], spacing: 16)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 20, left: 20, bottom: 20, right: 20))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

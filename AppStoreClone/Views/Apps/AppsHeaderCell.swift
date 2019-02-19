//
//  AppsHeaderCell.swift
//  AppStoreClone
//
//  Created by krAyon on 19.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class AppsHeaderCell: UICollectionViewCell {
    
    let companyLabel = UILabel(text: "Facebook", font: .boldSystemFont(ofSize: 12))
    let titlelabel = UILabel(text: "Keeping up with friends in faster than ever", font: .systemFont(ofSize: 24))
    let imageView = UIImageView(cornerradius: 8)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.backgroundColor = .red
        titlelabel.numberOfLines = 2
        companyLabel.textColor = .blue
        let stackView = VerticalStackView(arrangedSubViews: [
            companyLabel, titlelabel, imageView
            ], spacing: 12)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 16, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

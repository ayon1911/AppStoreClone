//
//  AppsGroupCell.swift
//  AppStoreClone
//
//  Created by krAyon on 19.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit


class AppsGroupCell: UICollectionViewCell {
    
    let appSectionTitlelabel = UILabel(text: "App Section", font: .boldSystemFont(ofSize: 24))
    
    let horizontalVC = AppsHorizontalVC()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        backgroundColor = .lightGray
        addSubview(appSectionTitlelabel)
        appSectionTitlelabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))
        
        addSubview(horizontalVC.view)
        horizontalVC.view.anchor(top: appSectionTitlelabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
//        horizontalVC.view.backgroundColor = .blue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

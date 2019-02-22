//
//  ScreenshotCell.swift
//  AppStoreClone
//
//  Created by krAyon on 22.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class ScreenShotCell: UICollectionViewCell {
    
    let imageView = UIImageView(cornerradius: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
        imageView.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

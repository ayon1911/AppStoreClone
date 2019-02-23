//
//  ReviewRowCell.swift
//  AppStoreClone
//
//  Created by krAyon on 23.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .gray
        addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

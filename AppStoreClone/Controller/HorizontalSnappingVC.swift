//
//  HorizontalSnappingVC.swift
//  AppStoreClone
//
//  Created by krAyon on 20.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class HorizontalSnappingVC: UICollectionViewController {
    
    init() {
        let layout = SnappingLayout()
        layout.scrollDirection = .horizontal
        super.init(collectionViewLayout: layout)
        collectionView.decelerationRate = .fast
        layout.register(SeparatorView.self, forDecorationViewOfKind: separatorDecorationView)
        layout.minimumLineSpacing = 8
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

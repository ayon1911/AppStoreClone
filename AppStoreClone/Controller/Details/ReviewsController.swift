//
//  ReviewsController.swift
//  AppStoreClone
//
//  Created by krAyon on 23.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class ReviewsController: HorizontalSnappingVC, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(ReviewCell.self, forCellWithReuseIdentifier: ReviewCell.cellID)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewCell.cellID, for: indexPath) as! ReviewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 48, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
}

//
//  TodayMultipleAppController.swift
//  AppStoreClone
//
//  Created by krAyon on 16.03.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class TodayMultipleAppController: BaseListVC, UICollectionViewDelegateFlowLayout {
    
    var results = [FeedResult]()
    fileprivate let spacing: CGFloat = 16
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.isScrollEnabled = false
        collectionView.register(MultipleAppCell.self, forCellWithReuseIdentifier: MultipleAppCell.cellID)
        
        Service.shared.fetchGames { (appGroup, error) in
            self.results = appGroup?.feed.results ?? []
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(4, results.count)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MultipleAppCell.cellID, for: indexPath) as! MultipleAppCell
        cell.app = results[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height: CGFloat = (view.frame.height - 3 * spacing) / 4
        return .init(width: view.frame.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
}

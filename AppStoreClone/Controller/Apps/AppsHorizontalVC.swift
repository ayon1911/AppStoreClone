//
//  AppsHorizontalVC.swift
//  AppStoreClone
//
//  Created by krAyon on 19.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class AppsHorizontalVC: HorizontalSnappingVC, UICollectionViewDelegateFlowLayout {
    
    let topBottomPadding: CGFloat = 12
    let lineSpacing: CGFloat = 12
    
    var appGroup: AppGroup?
    var didSelectHandler: ((FeedResult) -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(AppRowCell.self, forCellWithReuseIdentifier: AppRowCell.cellID)
        collectionView.backgroundColor = .white
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let app = appGroup?.feed.results[indexPath.item] else { return }
        didSelectHandler?(app)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return lineSpacing
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return appGroup?.feed.results.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppRowCell.cellID, for: indexPath) as! AppRowCell
        let app = appGroup?.feed.results[indexPath.item]
        cell.nameLable.text = app?.name
        cell.companyLabel.text = app?.artistName
        cell.imageView.sd_setImage(with: URL(string: app?.artworkUrl100 ?? ""), completed: nil)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.height - 2 * topBottomPadding - 2 * lineSpacing) / 3
        return CGSize.init(width: view.frame.width - 48, height: height)
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets.init(top: topBottomPadding, left: 16, bottom: topBottomPadding, right: 16)
//    }
}

//
//  PreviewScreenshotController.swift
//  AppStoreClone
//
//  Created by krAyon on 22.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class PreviewScreenshotController: HorizontalSnappingVC,UICollectionViewDelegateFlowLayout {
    
    var app: Result? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(ScreenShotCell.self, forCellWithReuseIdentifier: ScreenShotCell.cellID)
        
        collectionView.contentInset = .init(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return app?.screenshotUrls.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenShotCell.cellID, for: indexPath) as! ScreenShotCell
        let screenshotUrl = self.app?.screenshotUrls[indexPath.item] ?? ""
        cell.imageView.sd_setImage(with: URL(string: screenshotUrl))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: 250, height: view.frame.height)
    }
}

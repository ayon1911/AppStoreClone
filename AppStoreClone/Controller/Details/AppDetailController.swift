//
//  AppDetailController.swift
//  AppStoreClone
//
//  Created by krAyon on 21.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class AppDetailController: BaseListVC, UICollectionViewDelegateFlowLayout {
    
    var appId: String! {
        didSet {
            let urlString = "https://itunes.apple.com/lookup?id=\(appId ?? "")"
            Service.shared.fetchGenericJsonData(urlString: urlString) { (result: SearchResult?, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                let app = result?.results.first
                self.app = app
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
            let reviewsUrl = "https://itunes.apple.com/rss/customerreviews/page=1/id=\(appId ?? "")/sortby=mostrecent/json?l=en&cc=us"
            Service.shared.fetchGenericJsonData(urlString: reviewsUrl) { (reviews: Reviews?, error) in
                if let err = error {
                    print(err.localizedDescription)
                }
                self.reviews = reviews
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    var app: Result?
    var reviews: Reviews?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.cellID)
        collectionView.register(PreviewCell.self, forCellWithReuseIdentifier: PreviewCell.cellID)
        collectionView.register(ReviewRowCell.self, forCellWithReuseIdentifier: ReviewRowCell.cellID)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.cellID, for: indexPath) as! AppDetailCell
            cell.app = app
            return cell
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.cellID, for: indexPath) as! PreviewCell
            cell.horizontalContoller.app = self.app
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ReviewRowCell.cellID, for: indexPath) as! ReviewRowCell
            cell.reviewsController.reviews = self.reviews
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        var height: CGFloat = 280
        if indexPath.item == 0 {
            let dummyCell = AppDetailCell(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: .greatestFiniteMagnitude))
            dummyCell.app = app
            dummyCell.layoutIfNeeded()
            
            let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: .greatestFiniteMagnitude))
            height = estimatedSize.height
            
        } else if indexPath.item == 1 {
            height = 500
        } else {
            height = 280
        }
        return .init(width: view.frame.width, height: height)
    }
}

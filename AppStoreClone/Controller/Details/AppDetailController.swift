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
        }
    }
    
    var app: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .white
        collectionView.register(AppDetailCell.self, forCellWithReuseIdentifier: AppDetailCell.cellID)
        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppDetailCell.cellID, for: indexPath) as! AppDetailCell
        cell.app = app
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let dummyCell = AppDetailCell(frame: CGRect.init(x: 0, y: 0, width: view.frame.width, height: 1000))
        dummyCell.app = app
        dummyCell.layoutIfNeeded()
        
        let estimatedSize = dummyCell.systemLayoutSizeFitting(.init(width: view.frame.width, height: 1000))
        return .init(width: view.frame.width, height: estimatedSize.height)
    }
}

//
//  AppsVC.swift
//  AppStoreClone
//
//  Created by krAyon on 19.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class AppsPageVC: BaseListVC, UICollectionViewDelegateFlowLayout {
    
    let headerID = "headerId"
//    var editorsChoiseGame: AppGroup?
    
    var groups = [AppGroup]()
    var socialApps = [SocialApp]()
    
    let activityIndicator: UIActivityIndicatorView = {
       let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        view.addSubview(activityIndicator)
        activityIndicator.fillSuperview()
        
        collectionView.register(AppsGroupCell.self, forCellWithReuseIdentifier: AppsGroupCell.cellID)
        collectionView.register(AppsPageHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerID)
        
        fetchData()
    }
    
    fileprivate func fetchData() {
        var group1: AppGroup?
        var group2: AppGroup?
        var group3: AppGroup?
        
        
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            dispatchGroup.leave()
            group1 = appGroup
        }
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing(completion: { (appGroup, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            dispatchGroup.leave()
            group2 = appGroup
        })
        dispatchGroup.enter()
        Service.shared.fetchAppGroup(urlString: "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-free/all/50/explicit.json") { (appGroup, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            dispatchGroup.leave()
            group3 = appGroup
        }
        dispatchGroup.enter()
        Service.shared.fetchSocialApp { (apps, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            dispatchGroup.leave()
            self.socialApps = apps ?? []
        }
        
        dispatchGroup.notify(queue: .main) {
            self.activityIndicator.stopAnimating()
            if let group = group1 {
                self.groups.append(group)
            }
            if let group = group2 {
                self.groups.append(group)
            }
            if let group = group3 {
                self.groups.append(group)
            }
            self.collectionView.reloadData()
        }
        
       
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AppsPageHeader
        header.appHeaderHorizontalVC.socialApps = self.socialApps
        header.appHeaderHorizontalVC.collectionView.reloadData()
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppsGroupCell.cellID, for: indexPath) as! AppsGroupCell
        let appGroup = groups[indexPath.item]
        cell.appSectionTitlelabel.text = appGroup.feed.title
        cell.horizontalVC.appGroup = appGroup
        cell.horizontalVC.didSelectHandler = { [weak self] feedResult in
            let vc = AppDetailController()
            vc.navigationItem.title = feedResult.name
            self?.navigationController?.pushViewController(vc, animated: true)
        }
        cell.horizontalVC.collectionView.reloadData()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 300)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}

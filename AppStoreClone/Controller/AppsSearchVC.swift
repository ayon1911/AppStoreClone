//
//  AppsSearchVC.swift
//  AppStoreClone
//
//  Created by krAyon on 18.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchVC: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate{
    
    var timer: Timer?
    
    fileprivate var appResult = [Result]()
    
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    fileprivate let enterSearchTermLable: UILabel = {
        let label = UILabel()
        label.text = "Please enter search Term Above..."
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.cellID)
        
        collectionView.addSubview(enterSearchTermLable)
        enterSearchTermLable.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: -50))
        
        setupSearchBar()
        
//        fetchItunesApps()
    }
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    fileprivate func fetchItunesApps() {
        Service.shared.fetchApps(searchTerm: "") { (results, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            self.appResult = results
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLable.isHidden = appResult.count != 0
        return appResult.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.cellID, for: indexPath) as! SearchResultCell
        cell.appResult = appResult[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { (_) in
            Service.shared.fetchApps(searchTerm: searchText) { (results, error) in
                self.appResult = results
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        })
    }
}



//
//  AppsSearchVC.swift
//  AppStoreClone
//
//  Created by krAyon on 18.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class AppsSearchVC: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: SearchResultCell.cellID)
        
        fetchItunesApps()
    }
    
    fileprivate func fetchItunesApps() {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        let url = URL(string: urlString)
        
        URLSession.shared.dataTask(with: url!) { (data, res, error) in
            if let err = error {
                print(err.localizedDescription)
                return
            }
            guard let data = data else { return }
            do {
            let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                searchResult.results.forEach({ print($0.trackName, $0.primaryGenreName) })
            } catch {
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCell.cellID, for: indexPath) as! SearchResultCell
        cell.nameLable.text = "Hear is my app name"
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
}



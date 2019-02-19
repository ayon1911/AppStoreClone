//
//  Service.swift
//  AppStoreClone
//
//  Created by krAyon on 19.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { fatalError() }
   
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let err = error {
                print(err.localizedDescription)
                completion([], err)
                return
            }
            guard let data = data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
               completion(searchResult.results, nil)
            } catch {
                print(error.localizedDescription)
                completion([], error)
            }
            }.resume()
    }
}

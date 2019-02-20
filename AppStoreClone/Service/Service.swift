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
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) ->()) {
       let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: url, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let url = "https://rss.itunes.apple.com/api/v1/us/ios-apps/top-grossing/all/50/explicit.json"
       fetchAppGroup(urlString: url, completion: completion)
    }
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil, err)
                return
            }
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                print(error.localizedDescription)
            }
            
            }.resume()
    }
    
    func fetchSocialApp(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { (data, res, error) in
            if let err = error {
                print(err.localizedDescription)
                completion(nil, err)
                return
            }
            do {
                let objs = try JSONDecoder().decode([SocialApp].self, from: data!)
                completion(objs, nil)
            } catch {
                completion(nil, error)
                print(error.localizedDescription)
            }
            
            }.resume()
    }
}

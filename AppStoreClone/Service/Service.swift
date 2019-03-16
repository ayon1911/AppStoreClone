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
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        fetchGenericJsonData(urlString: urlString, completion: completion)
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
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApp(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString = "https://api.letsbuildthatapp.com/appstore/social"
        fetchGenericJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchGenericJsonData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> ()) {
        //        guard let url = URL(string: urlString) else { return }
        //        URLSession.shared.dataTask(with: url) { (data, res, error) in
        //            if let err = error {
        //                print(err.localizedDescription)
        //                completion(nil, err)
        //                return
        //            }
        //            do {
        //                let objs = try JSONDecoder().decode(T.self, from: data!)
        //                completion(objs, nil)
        //            } catch {
        //                completion(nil, error)
        //                print(error.localizedDescription)
        //            }
        //
        //            }.resume()
        guard let url = URL(string: urlString) else { fatalError("Invalid Url")}
        DispatchQueue.global().async {
            do {
                let data = try Data(contentsOf: url)
                let downloadedData = try JSONDecoder().decode(T.self, from: data)
                DispatchQueue.main.async {
                    completion(downloadedData, nil)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

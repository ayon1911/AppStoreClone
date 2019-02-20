//
//  AppGroup.swift
//  AppStoreClone
//
//  Created by krAyon on 20.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}

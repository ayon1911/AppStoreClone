//
//  TodayItem.swift
//  AppStoreClone
//
//  Created by krAyon on 15.03.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

struct TodayItem {
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    let cellType: CellType
    let apps: [FeedResult]
    
    enum CellType: String {
        case single, multiple
    }
}

//
//  PreviewCellCollectionViewCell.swift
//  AppStoreClone
//
//  Created by krAyon on 22.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class PreviewCell: UICollectionViewCell {
 
    let horizontalContoller = PreviewScreenshotController()
    
    let previewLabel = UILabel(text: "Preview", font: .boldSystemFont(ofSize: 24))
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(previewLabel)
        addSubview(horizontalContoller.view)
        
        previewLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 20, bottom: 0, right: 20))
        horizontalContoller.view.anchor(top: previewLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top:20, left: 0, bottom: 0, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

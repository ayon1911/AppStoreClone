//
//  VerticalStackView.swift
//  AppStoreClone
//
//  Created by krAyon on 18.02.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class VerticalStackView: UIStackView {

    init(arrangedSubViews: [UIView], spacing: CGFloat = 0) {
        super.init(frame: .zero)
        arrangedSubViews.forEach({addArrangedSubview($0)})
        self.spacing = spacing
        self.axis = .vertical
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

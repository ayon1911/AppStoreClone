//
//  TodayVC+Extentions.swift
//  AppStoreClone
//
//  Created by krAyon on 31.03.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

extension TodayVC: UIGestureRecognizerDelegate {
    
    @objc func handleDrag(gesture: UIPanGestureRecognizer) {
        struct StaticVar { static var appFullScreenBeginOffset: CGFloat = 0 } // persists the begining offset
        
        func scaled(_ traslateY: CGFloat, from beginOffset: CGFloat) -> CGFloat {
            let trueOffset = traslateY - beginOffset
            let scaled = 1 - trueOffset / 1000
            return min(1, max(0.5, scaled))
        }
        
        if gesture.state == .began {
            StaticVar.appFullScreenBeginOffset = appFullScreen.tableView.contentOffset.y
        }
        guard appFullScreen.tableView.contentOffset.y > 0 ? false : true else { return }
        let traslationY = gesture.translation(in: appFullScreen.view).y
        guard traslationY > 0 else { return }
        
        if gesture.state == .changed {
            let scale = scaled(traslationY, from: StaticVar.appFullScreenBeginOffset)
            let trasform: CGAffineTransform = .init(scaleX: scale, y: scale)
            self.appFullScreen.view.transform = trasform
        } else if gesture.state == .ended {
            handleAppFullScreenDismiss()
        }
        
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

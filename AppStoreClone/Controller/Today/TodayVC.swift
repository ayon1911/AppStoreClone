//
//  TodayVC.swift
//  AppStoreClone
//
//  Created by krAyon on 03.03.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class TodayVC: BaseListVC, UICollectionViewDelegateFlowLayout {
    
    var startingFrame: CGRect?
    var appFullScreen: AppFullScreenVC!
    static let cellSize: CGFloat = 500
    
    let items = [
        TodayItem.init(category: "Life Hack", title: "Utilizing", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way", backgrounColor: .white, cellType: .single),
        TodayItem.init(category: "HOLIDAYS", title: "Travel on Budjet", image: #imageLiteral(resourceName: "holiday"), description: "Travel is good for everyone to see what's behind the horaizon", backgrounColor: #colorLiteral(red: 0.9857528806, green: 0.9669142365, blue: 0.7202112079, alpha: 1), cellType: .single),
        TodayItem.init(category: "THE DAILY LIST", title: "Test-Drive These Carplay", image: #imageLiteral(resourceName: "garden"), description: "", backgrounColor: .white, cellType: .multiple),
        ]
    
    var topConstraint, leadingConstraint, widthConstraint, heightConstraint: NSLayoutConstraint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9416126609, green: 0.9407772422, blue: 0.9711847901, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMulptipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = items[indexPath.item].cellType
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId.rawValue, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width - 64, height: TodayVC.cellSize)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 32, left: 0, bottom: 32, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let appFullScreenVC = AppFullScreenVC()
        guard let fullScreenView = appFullScreenVC.view else { return }
        view.addSubview(fullScreenView)
        addChild(appFullScreenVC)
        
        appFullScreenVC.todayItem = items[indexPath.item]
        appFullScreenVC.dismissHandler = {
            self.handleRemoveRedView()
        }
        
        self.appFullScreen = appFullScreenVC
        self.collectionView.isUserInteractionEnabled = false
        
        fullScreenView.layer.cornerRadius = 16
        
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        
        //auto layout constraint animations
        fullScreenView.translatesAutoresizingMaskIntoConstraints = false
        topConstraint = fullScreenView.topAnchor.constraint(equalTo: view.topAnchor, constant: startingFrame.origin.y)
        leadingConstraint = fullScreenView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: startingFrame.origin.x)
        widthConstraint = fullScreenView.widthAnchor.constraint(equalToConstant: startingFrame.width)
        heightConstraint = fullScreenView.heightAnchor.constraint(equalToConstant: startingFrame.height)
        
        [topConstraint, leadingConstraint, widthConstraint, heightConstraint].forEach({$0?.isActive = true})
        self.view.layoutIfNeeded()
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            
            self.topConstraint?.constant = 0
            self.leadingConstraint?.constant = 0
            self.heightConstraint?.constant = self.view.frame.height
            self.widthConstraint?.constant = self.view.frame.width
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = self.appFullScreen.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    @objc func handleRemoveRedView() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
//            gesture.view?.frame = self.startingFrame ?? .zero
            self.appFullScreen.tableView.contentOffset = .zero
            guard let startingFrame = self.startingFrame else { return }
            self.tabBarController?.tabBar.transform = .identity
            self.topConstraint?.constant = startingFrame.origin.y
            self.leadingConstraint?.constant = startingFrame.origin.x
            self.widthConstraint?.constant = startingFrame.width
            self.heightConstraint?.constant = startingFrame.height
            
            guard let cell = self.appFullScreen.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
//            gesture.view?.removeFromSuperview()
            self.appFullScreen.view.removeFromSuperview()
            self.appFullScreen.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
}

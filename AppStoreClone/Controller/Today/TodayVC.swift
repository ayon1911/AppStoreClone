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
    
    var items = [TodayItem]()
    let activityIndicator: UIActivityIndicatorView = {
        let ac = UIActivityIndicatorView(style: .whiteLarge)
        ac.color = .darkGray
        ac.startAnimating()
        ac.hidesWhenStopped = true
        return ac
    }()
    
    let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
//    var appFullScreenBeginOffset: CGFloat = 0
    
    var anchoredConstraints: AnchoredConstraints?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        blurVisualEffectView.alpha = 0
        
        view.addSubview(activityIndicator)
        activityIndicator.centerInSuperview()
        
        fetchData()
        
        collectionView.backgroundColor = #colorLiteral(red: 0.9416126609, green: 0.9407772422, blue: 0.9711847901, alpha: 1)
        collectionView.register(TodayCell.self, forCellWithReuseIdentifier: TodayItem.CellType.single.rawValue)
        collectionView.register(TodayMulptipleAppCell.self, forCellWithReuseIdentifier: TodayItem.CellType.multiple.rawValue)
        
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.superview?.setNeedsLayout()
    }
    
    fileprivate func fetchData() {
        let dispatchGroup = DispatchGroup()
        var topGrossingGroup: AppGroup?
        var gamesGroup: AppGroup?
        
        dispatchGroup.enter()
        Service.shared.fetchTopGrossing { (appGroup, error) in
            if let err = error {
                print("Error fetching data", err)
            }
            topGrossingGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.enter()
        Service.shared.fetchGames { (appGroup, error) in
            if let err = error {
                print("Error fetching data", err)
            }
            gamesGroup = appGroup
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main) {
            // I'll have access to top grossing and games somehow
            
            print("Finished fetching")
            self.activityIndicator.stopAnimating()
            
            self.items = [
                TodayItem.init(category: "LIFE HACK", title: "Utilizing your Time", image: #imageLiteral(resourceName: "garden"), description: "All the tools and apps you need to intelligently organize your life the right way.", backgroundColor: .white, cellType: .single, apps: []),
                TodayItem.init(category: "Daily List", title: topGrossingGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: topGrossingGroup?.feed.results ?? []),
                
                TodayItem.init(category: "Daily List", title: gamesGroup?.feed.title ?? "", image: #imageLiteral(resourceName: "garden"), description: "", backgroundColor: .white, cellType: .multiple, apps: gamesGroup?.feed.results ?? []),
                
                TodayItem.init(category: "HOLIDAYS", title: "Travel on a Budget", image: #imageLiteral(resourceName: "holiday"), description: "Find out all you need to know on how to travel without packing everything!", backgroundColor: #colorLiteral(red: 0.9838578105, green: 0.9588007331, blue: 0.7274674177, alpha: 1), cellType: .single, apps: []),
            ]
            
            self.collectionView.reloadData()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cellId = items[indexPath.item].cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseTodayCell
        cell.todayItem = items[indexPath.item]
        
        (cell as? TodayMulptipleAppCell)?.multipleAppsController.collectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleMultipleAppsTap)))
        
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
    
    fileprivate func showDailyListFullScreen(_ indexPath: IndexPath) {
        let fullController = TodayMultipleAppController(mode: .fullScreen)
        fullController.apps = self.items[indexPath.item].apps
        present(BackEnabledNavigationController(rootViewController: fullController), animated: true, completion: nil)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch items[indexPath.item].cellType {
        case .multiple:
            showDailyListFullScreen(indexPath)
        default:
            showSingleAppFullScreen(indexpath: indexPath)
        }
    }
    
    fileprivate func setupSingleAppFullScreenController(_ indexPath: IndexPath) {
        let appFullScreenVC = AppFullScreenVC()
        appFullScreenVC.todayItem = items[indexPath.item]
        appFullScreenVC.dismissHandler = {
            self.handleAppFullScreenDismiss()
        }
        self.appFullScreen = appFullScreenVC
        appFullScreenVC.view.layer.cornerRadius = 16
        
        //adding a pan gestures
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        gesture.delegate = self
        appFullScreenVC.view.addGestureRecognizer(gesture)
    }
    
//    @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer) {
//        if gesture.state == .changed {
//            appFullScreenBeginOffset = appFullScreen.tableView.contentOffset.y
//        }
//        if appFullScreen.tableView.contentOffset.y > 0 {
//            return
//        }
//        let traslationY = gesture.translation(in: appFullScreen.view).y
//
//
//        if gesture.state == .changed {
//            if traslationY > 0 {
//                let trueOffset = traslationY - appFullScreenBeginOffset
//                var scale = 1 - trueOffset / 1000
//                scale = min(1, scale)
//                scale = max(0.5, scale)
//                let trasform: CGAffineTransform = .init(scaleX: scale, y: scale)
//                self.appFullScreen.view.transform = trasform
//            }
//        }
//        else if gesture.state == .ended {
//            if traslationY > 0 {
//                handleAppFullScreenDismiss()
//            }
//
//        }
//    }
//
//    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
//        return true
//    }
    
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
    }
    
    fileprivate func setupAppFullScreenStartingPosition(_ indexPath: IndexPath) {
        guard let fullScreenView = appFullScreen.view else { return }
        view.addSubview(fullScreenView)
        addChild(appFullScreen)
        self.collectionView.isUserInteractionEnabled = false
        
        setupStartingCellFrame(indexPath)
        
        guard let startingFrame = self.startingFrame else { return }
        self.anchoredConstraints = fullScreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        self.view.layoutIfNeeded()
    }
    
    fileprivate func beginAnimationAppFullScrren() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.blurVisualEffectView.alpha = 1
            self.anchoredConstraints?.top?.constant = 0
            self.anchoredConstraints?.leading?.constant = 0
            self.anchoredConstraints?.height?.constant = self.view.frame.height
            self.anchoredConstraints?.width?.constant = self.view.frame.width
            self.view.layoutIfNeeded()
            
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            
            guard let cell = self.appFullScreen.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else { return }
            cell.todayCell.topConstraint.constant = 48
            cell.layoutIfNeeded()
            
        }, completion: nil)
    }
    
    fileprivate func showSingleAppFullScreen(indexpath: IndexPath) {
        setupSingleAppFullScreenController(indexpath)
        setupAppFullScreenStartingPosition(indexpath)
        beginAnimationAppFullScrren()
    }
    
    @objc func handleAppFullScreenDismiss() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.blurVisualEffectView.alpha = 0
            self.appFullScreen.view.transform = .identity
            self.appFullScreen.tableView.contentOffset = .zero
            guard let startingFrame = self.startingFrame else { return }
            self.tabBarController?.tabBar.transform = .identity
            self.anchoredConstraints?.top?.constant = startingFrame.origin.y
            self.anchoredConstraints?.leading?.constant = startingFrame.origin.x
            self.anchoredConstraints?.width?.constant = startingFrame.width
            self.anchoredConstraints?.height?.constant = startingFrame.height
            
            guard let cell = self.appFullScreen.tableView.cellForRow(at: [0,0]) as? AppFullscreenHeaderCell else { return }
            self.appFullScreen.closeButton.alpha = 0
            cell.todayCell.topConstraint.constant = 24
            cell.layoutIfNeeded()
            
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.appFullScreen.view.removeFromSuperview()
            self.appFullScreen.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    
    @objc fileprivate func handleMultipleAppsTap(gesture: UITapGestureRecognizer) {
        let collectionView = gesture.view
        
        var superView = collectionView?.superview
        while superView != nil {
            if let cell = superView as? TodayMulptipleAppCell {
                guard let indexPath = self.collectionView.indexPath(for: cell) else { return }
                let fullController = TodayMultipleAppController(mode: .fullScreen)
                let apps = self.items[indexPath.item].apps
                fullController.apps = apps
                present(BackEnabledNavigationController(rootViewController: fullController), animated: true, completion: nil)
                return 
            }
            superView = superView?.superview
        }
    }
}

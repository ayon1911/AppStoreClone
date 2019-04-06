//
//  AppFullScreenVC.swift
//  AppStoreClone
//
//  Created by krAyon on 03.03.19.
//  Copyright © 2019 DocDevs. All rights reserved.
//

import UIKit

class AppFullScreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dismissHandler: (() -> ())?
    var todayItem: TodayItem?
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        return button
    }()
    
    let tableView = UITableView(frame: .zero, style: .plain)
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            //to active scroll after the darging is off
            scrollView.isScrollEnabled = true
        }
    }
    
    fileprivate func setupTableVIew() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.delegate = self
        tableView.dataSource = self
        setupCloseButton()
        
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.statusBarFrame.height
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.clipsToBounds = true
        setupTableVIew()
        
        setupFlotingControls()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let headerCell = AppFullscreenHeaderCell()
            headerCell.todayCell.todayItem = todayItem
            headerCell.todayCell.layer.cornerRadius = 0
            headerCell.clipsToBounds = true
            headerCell.todayCell.backgroundView = nil
            return headerCell
        }
        
        let cell = AppFullScreenDescriptionCell()
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return TodayVC.cellSize
        }
        return UITableView.automaticDimension
    }
    
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 12), size: .init(width: 80, height: 38))
        closeButton.addTarget(self, action: #selector(handleDismiss), for: .touchUpInside)
        
    }
    
    fileprivate func setupFlotingControls() {
        let floatingContainerView = UIView()
        floatingContainerView.clipsToBounds = true
        floatingContainerView.layer.cornerRadius = 16
        let bottomPadding = UIApplication.shared.statusBarFrame.height
        view.addSubview(floatingContainerView)
        floatingContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: 16, bottom: bottomPadding, right: 16), size: .init(width: 0, height: 100))
        let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
        floatingContainerView.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        
        setupFloatingSubViews(floatingContainerView)
    }
    
    fileprivate func setupFloatingSubViews(_ floatingContainerView: UIView) {
        let imageView = UIImageView(cornerradius: 16)
        imageView.image = todayItem?.image
        imageView.constrainHeight(constant: 68)
        imageView.constrainWidth(constant: 68)
        
        let getButton = UIButton(title: "GET")
        getButton.setTitleColor(.white, for: .normal)
        getButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        getButton.backgroundColor = .darkGray
        getButton.layer.cornerRadius = 16
        getButton.constrainHeight(constant: 32)
        getButton.constrainWidth(constant: 80)
        
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            VerticalStackView(arrangedSubViews: [
                UILabel(text: "Life Hack", font: .boldSystemFont(ofSize: 18)),
                UILabel(text: "Utilizing your time", font: .boldSystemFont(ofSize: 18))
                ], spacing: 4),
            getButton
            ], customSpacing: 16)
        
        floatingContainerView.addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 0, left: 16, bottom: 0, right: 16))
        stackView.alignment = .center
    }
}

//
//  ViewController.swift
//  YouTubeEx
//
//  Created by user140592 on 1/3/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellid"

    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
        
    }
    
    private func setupCollectionView() {
        // Make collectionView csroll horizontal.
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView.backgroundColor = .white
        
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.contentInset = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)
        collectionView.scrollIndicatorInsets = UIEdgeInsets(top: 50, left: 0, bottom: 0, right: 0)

        collectionView.isPagingEnabled = true
    }
    
    func setupNavBarButtons(){
        let searchImage = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal)
        let searchBarButtonIten = UIBarButtonItem(image: searchImage, style: .plain, target: self, action: #selector(handleSearch))
        
        let moreButton = UIBarButtonItem(image: UIImage(named: "menu")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handelMore))
        navigationItem.rightBarButtonItems = [moreButton, searchBarButtonIten]
    }
    
    lazy var settingsLauncher : SettingsLauncher = {
        let launcher = SettingsLauncher()
        launcher.homeController = self
        return launcher
    }()
    
    @objc
    func handelMore() {
        //show manu
        settingsLauncher.showSettings()
    }
    
    func showControllerForSetting(setting: Setting) {
        let dummySettingsViewController = UIViewController()
        dummySettingsViewController.view.backgroundColor = .white
        dummySettingsViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = .white
        navigationController?.pushViewController(dummySettingsViewController, animated: true)
    }
    
    @objc
    func handleSearch(){
        scrollToMenuInadex(menuIndex: 2)
    }
    
    func scrollToMenuInadex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: true)
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "   \(titles[menuIndex])"
        }
    }
    
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homeController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        return mb
    }()
    
    private func setupMenuBar(){
        // Hide the navigation bar when swipe
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.translatesAutoresizingMaskIntoConstraints = false
        redView.backgroundColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        view.addSubview(redView)
        
        view.addSubview(menuBar)
        // menuBar constraints.
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // redView
        redView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        redView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        redView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        redView.heightAnchor.constraint(equalToConstant: 50).isActive = true

    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.horizontalBarLeadingConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    let titles = ["Home", "Treanding", "Subscriptions", "Account"]
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        // Meanu index
        let index = targetContentOffset.pointee.x / view.frame.width
        
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .right)
        
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "   \(titles[Int(index)])"
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - 50)
    }

    
}

    
            


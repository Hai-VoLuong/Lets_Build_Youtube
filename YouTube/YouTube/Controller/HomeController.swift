//
//  ViewController.swift
//  YouTube
//
//  Created by MAC on 1/29/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import LBTAComponents
import RxSwift
import RxCocoa

final class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Private Properties
    private let bag = DisposeBag()
    fileprivate let cellId = "Cell"
    
    lazy private var settingLauncher: SettingsLauncher = {
        let laucher = SettingsLauncher()
        laucher.homeController = self
        return laucher
    }()
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.homController = self
        return mb
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isTranslucent = false
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32 , height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        setupCollectionView()
        setupMenuBar()
        setupNavBarButtons()
    }
    
    // MARK: - Private Func
    private func setupCollectionView() {
        if let flowLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            flowLayout.scrollDirection = .horizontal
            flowLayout.minimumLineSpacing = 0
        }
        
        collectionView?.backgroundColor = .white
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        // khoang cach collectionView voi top home
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    private func setupNavBarButtons() {
        let searchBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        
        let moreBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more").withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        
        moreBarButtonItem.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let this = self else { return }
                this.settingLauncher.showSettings()
            }).disposed(by: bag)
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }
    
    @objc fileprivate func handleSearch() {
        scrollToMenuIndex(menuIndex: 2)
    }
    
    func scrollToMenuIndex(menuIndex: Int) {
        let indexPath = IndexPath(item: menuIndex, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: [], animated: true)
    }
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor(r: 230, g: 32, b: 31)
        view.addSubview(redView)
        view.addConstraintsWithFormat("H:|[v0]|", views: redView)
        view.addConstraintsWithFormat("V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        view.addConstraintsWithFormat("V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    // MARK: - Public Func
    func showControllerForSetting(setting: Setting) {
        let dummySettingViewController = UIViewController()
        dummySettingViewController.navigationItem.title = setting.name.rawValue
        dummySettingViewController.view.backgroundColor = .white
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor.white]
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    // fix scroll menubar thì icon cũng sáng theo
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        
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


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

final class HomeController: UICollectionViewController {
    
    // MARK: - Private Properties
    private var videos: [Video]?
    private let bag = DisposeBag()
    
    lazy private var settingLauncher: SettingsLauncher = {
        let laucher = SettingsLauncher()
        laucher.homeController = self
        return laucher
    }()
    
    private let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetVideos()
        
        navigationController?.navigationBar.isTranslucent = false
    
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32 , height: view.frame.height))
        titleLabel.text = "Home"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "Cell")
        
        // khoang cach collectionView voi top home
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        setupMenuBar()
        setupNavBarButtons()
    }
    
    // MARK: - Private Func
    private func fetVideos() {
        ApiService.sharedInstance.fetchVideos { (videos) in
            self.videos = videos
            self.collectionView?.reloadData()
        }
    }
    
    private func setupNavBarButtons() {
        let searchBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)

        let moreBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more").withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        
        moreBarButtonItem.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                guard let this = self else { return }
                this.settingLauncher.showSettings()
            }).disposed(by: bag)
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = (view.frame.width - 16 - 16) * 9 / 16
        return CGSize(width: view.frame.width, height: height + 16 + 60)
    }
}

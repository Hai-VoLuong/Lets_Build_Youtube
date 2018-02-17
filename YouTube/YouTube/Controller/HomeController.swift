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

class HomeController: UICollectionViewController {
    
    var videos: [Video]?
    let bag = DisposeBag()
    
    func fetVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!) { [weak self] (data, response, error) in
            guard let this = self else { return }
            if error != nil {
                print(error ?? "")
                return
            }
            do {
             let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                // 27 phut
                this.videos = [Video]()
                
                for dictinary in (json as! [[String: AnyObject]]) {
                    let video = Video()
                    video.title = dictinary["title"] as? String
                    video.thumbnailImageName = dictinary["thumbnail_image_name"] as? String
                    
                    let channelDictionary = dictinary["channel"] as? [String: AnyObject]
                    
                    let channel = Channel()
                    channel.name = channelDictionary!["name"] as? String
                    channel.profileImageName = channelDictionary!["profile_image_name"] as?
                        String
                    
                    video.channel = channel
                    
                    this.videos?.append(video)
                }
                DispatchQueue.main.async {
                    this.collectionView?.reloadData()
                }
               
                
            } catch let jsonError {
                print(jsonError)
            }
            
        }.resume()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetVideos()
        
        navigationItem.title = "Home"
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
    
    func setupNavBarButtons() {
        let searchBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "search").withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)

        let moreBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more").withRenderingMode(.alwaysOriginal), style: .plain, target: nil, action: nil)
        
        let settingLauncher = SettingsLauncher()
        moreBarButtonItem.rx.tap.asObservable()
            .subscribe(onNext: { [weak self] in
                settingLauncher.homeController = self
                settingLauncher.showSettings()
                
            }).disposed(by: bag)
        
        navigationItem.rightBarButtonItems = [moreBarButtonItem,searchBarButtonItem]
    }
    
    func showControllerForSetting() {
        let dummySettingViewController = UIViewController()
        navigationController?.pushViewController(dummySettingViewController, animated: true)
    }
    
    let menuBar: MenuBar = {
        let mb = MenuBar()
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
 
         menuBar.anchor(view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
        
        //       view.addConstraintsWithFormat("H:|[v0]|", views: menuBar)
        //       view.addConstraintsWithFormat("V:|[v0(50)]|", views: menuBar)
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

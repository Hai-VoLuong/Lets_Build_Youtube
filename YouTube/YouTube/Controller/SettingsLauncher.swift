//
//  SettingsLaucher.swift
//  YouTube
//
//  Created by MAC on 2/8/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class SettingsLauncher: NSObject {
    
    // MARK: - Properties
    private let bag = DisposeBag()
    private let blackView = UIView()
    fileprivate let cellHeight: CGFloat = 50
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()
    
    let settings: [Setting] = {
        return [Setting(name: "Setting", imageName: "settings"),
                Setting(name: "Term & privacy policy", imageName: "privacy"),
                Setting(name: "Send Feedback", imageName: "feedback"),
                Setting(name: "Help", imageName: "help"),
                Setting(name: "Switch Account", imageName: "switchaccount"),
                Setting(name: "Cancel", imageName: "cancel")]
    }()
    
    var homeController: HomeController?

    // MARK: - Public Func
    func showSettings() {
        handleDismiss()
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = CGFloat(settings.count) * cellHeight + cellHeight
            let y = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)
            
            blackView.frame = window.frame
            blackView.alpha = 0
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackView.alpha = 1
        
                self.collectionView.frame = CGRect(x: 0, y: y, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
    }
    
    // MARK: Private Func
    private func handleDismiss() {
        let tapGesture = UITapGestureRecognizer()
        blackView.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.bind(onNext: { [weak self] _ in
        guard let this = self else { return }
        UIView.animate(withDuration: 0.5, animations: {
                this.blackView.alpha = 0
                if let window = UIApplication.shared.keyWindow {
                    self?.collectionView.frame = CGRect(x: 0,
                    y: window.frame.height,
                    width: (self?.collectionView.frame.width)!,
                    height: (self?.collectionView.frame.height)!)
                }
            })
        }).disposed(by: bag)
    }
    
    override init() {
        super.init()
        collectionView.register(SettingCell.self, forCellWithReuseIdentifier: "Cell")
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension SettingsLauncher: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! SettingCell
        cell.setting = settings[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { [weak self] in
            guard let this = self else { return }
            this.blackView.alpha = 0
            if let window = UIApplication.shared.keyWindow {
                this.collectionView.frame = CGRect(x: 0,y: window.frame.height,
                    width: (this.collectionView.frame.width),
                    height: (this.collectionView.frame.height))
            }
        }) { [weak self] (completed: Bool) in
            guard let this = self else { return }
            this.homeController?.showControllerForSetting()
        }
    }
}






















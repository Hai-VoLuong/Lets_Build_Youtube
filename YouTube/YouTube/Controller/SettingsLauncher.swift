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

final class SettingsLauncher {
    
    private let bag = DisposeBag()
    private let blackView = UIView()
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        return cv
    }()

    func showSettings() {
       
        handleDismiss()
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            window.addSubview(collectionView)
            let height: CGFloat = 200
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
    
    init() {
        
    }
}

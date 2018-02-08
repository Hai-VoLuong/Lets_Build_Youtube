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

    func showSettings() {
        let tapGesture = UITapGestureRecognizer()
        blackView.addGestureRecognizer(tapGesture)
        tapGesture.rx.event.bind(onNext: { [weak self] _ in
            guard let this = self else { return }
            UIView.animate(withDuration: 0.5, animations: {
                this.blackView.alpha = 0
            })
        }).disposed(by: bag)
        
        if let window = UIApplication.shared.keyWindow {
            blackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
            window.addSubview(blackView)
            blackView.frame = window.frame
            blackView.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.blackView.alpha = 1
            })
        }
    }
    
    init() {
        
    }
}

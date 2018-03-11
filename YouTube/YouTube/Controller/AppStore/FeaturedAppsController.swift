//
//  FeaturedAppsController.swift
//  YouTube
//
//  Created by MAC on 3/9/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit

final class FeaturedAppsController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let cellId = "Cell"
    var appCategories: [AppCetegory]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appCategories = AppCetegory.sampleAppCategories()
        
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: cellId)
    }
}

// extension
extension FeaturedAppsController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let count = appCategories?.count {
            return count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CategoryCell
        cell.appCategory = appCategories?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 230)
    }
}

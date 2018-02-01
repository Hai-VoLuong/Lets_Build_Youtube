//
//  ViewController.swift
//  YouTube
//
//  Created by MAC on 1/29/18.
//  Copyright © 2018 MAC. All rights reserved.
//

import UIKit
import LBTAComponents

class HomeController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Home"
        collectionView?.backgroundColor = .white
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "Cell")
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}

extension HomeController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 200)
    }
}

class VideoCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    let thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let userProfileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        return imageView
    }()
    
    let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .purple
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .red
        return label
    }()
    
    func setupViews() {
        
        addSubview(thumbnailImageView)
        addSubview(separatorView)
        addSubview(userProfileImageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        thumbnailImageView.anchor(self.topAnchor, left: self.leftAnchor, bottom: userProfileImageView.topAnchor, right: self.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 4, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
        separatorView.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 1)
        
        userProfileImageView.anchor(thumbnailImageView.bottomAnchor, left: self.leftAnchor, bottom: separatorView.topAnchor, right: nil, topConstant: 0, leftConstant: 10, bottomConstant: 10, rightConstant: 10, widthConstant: 44, heightConstant: 44)
        
        titleLabel.anchor(thumbnailImageView.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 4, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 20)
        
        descriptionLabel.anchor(titleLabel.bottomAnchor, left: userProfileImageView.rightAnchor, bottom: separatorView.topAnchor, right: self.rightAnchor, topConstant: 5, leftConstant: 4, bottomConstant: 10, rightConstant: 10, widthConstant: 0, heightConstant: 0)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//
//  CustomCollectionViewControllerServices.swift
//  iCanGo-iOS
//
//  Created by Juan Carlos Merlos Albarracín on 7/7/16.
//  Copyright © 2016 CodeCrafters. All rights reserved.
//

import UIKit

class CustomCollectionViewControllerServices: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let reuseIdentifierCell = "iCanGoCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0, left: 20.0, bottom: 50.0, right: 20.0)
    
    let names = ["Pedrito", "Albertito", "Carlitos", "Javiercito", "Juan Carlitos", "Pedrito", "Albertito", "Carlitos", "Javiercito", "Juan Carlitos"]
    let price = ["200", "120", "22", "35", "40", "200", "120", "22", "35", "40"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.whiteColor()
        collectionView?.registerClass(CustomCell.self, forCellWithReuseIdentifier: reuseIdentifierCell)
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let customCell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifierCell, forIndexPath: indexPath) as! CustomCell
        customCell.descriptionLabel.text = names[indexPath.item]
        customCell.priceLabel.text = price[indexPath.item]
        return customCell
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, layout collecitonViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath: NSIndexPath) -> CGSize {
        return CGSizeMake(view.frame.width, 200)
    }
}


class CustomCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var priceLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom Text"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var photoUserImage: UIImageView = {
        var photoUserImage = UIImageView()
        photoUserImage = UIImageView(image: UIImage(named: "chica02.png"))
        photoUserImage.translatesAutoresizingMaskIntoConstraints = false
        return photoUserImage
    }()
    
    var photoServiceImage: UIImageView = {
        var photoServiceImage = UIImageView()
        photoServiceImage = UIImageView(image: UIImage(named: "furgoneta.png"))
        photoServiceImage.translatesAutoresizingMaskIntoConstraints = false
        return photoServiceImage
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backgroundColor = UIColor(red: 32/255, green: 155/255, blue: 177/255, alpha: 1)
        
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(photoUserImage)
        addSubview(photoServiceImage)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-220-[v0]|", options:
            NSLayoutFormatOptions(), metrics: nil, views: ["v0": descriptionLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[v0]|", options:
            NSLayoutFormatOptions(), metrics: nil, views: ["v0": descriptionLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-220-[v0]|", options:
            NSLayoutFormatOptions(), metrics: nil, views: ["v0": priceLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options:
            NSLayoutFormatOptions(), metrics: nil, views: ["v0": priceLabel]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-320-[v0(40)]|", options:
            NSLayoutFormatOptions(), metrics: nil, views: ["v0": photoUserImage]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-15-[v0(40)]|", options:
            NSLayoutFormatOptions(), metrics: nil, views: ["v0": photoUserImage]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-10-[v0(180)]|", options:
            NSLayoutFormatOptions(), metrics: nil, views: ["v0": photoServiceImage]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-10-[v0(180)]-10-|", options:
            NSLayoutFormatOptions(), metrics: nil, views: ["v0": photoServiceImage]))
        
    }
}








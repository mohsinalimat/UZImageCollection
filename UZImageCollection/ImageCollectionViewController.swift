//
//  ImageCollectionViewController.swift
//  UZImageCollectionView
//
//  Created by sonson on 2015/06/05.
//  Copyright (c) 2015年 sonson. All rights reserved.
//

import Foundation

public class ImageCollectionViewController : UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var cellSize:CGFloat = 0
    let collection:ImageCollection
    
    func numberOfItemsInLine() -> Int {
        return 4
    }
    
    init(collection:ImageCollection) {
        self.collection = collection
        var layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionViewScrollDirection.Vertical
        layout.minimumLineSpacing = 0
        super.init(collectionViewLayout: layout)
    }
    
    public required init(coder aDecoder: NSCoder) {
        self.collection = ImageCollection(files:[])
        super.init(coder: aDecoder)
    }
    
    public class func controller(files:[String]) -> ImageCollectionViewController {
        let collection = ImageCollection(files:files)
        let vc = ImageCollectionViewController(collection:collection)
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView?.registerClass(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.alwaysBounceVertical = true
        self.view.backgroundColor = UIColor.whiteColor()
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        
        cellSize = floor((self.view.frame.size.width - CGFloat(numberOfItemsInLine()) + 1) / CGFloat(numberOfItemsInLine()));
    }
    
    public override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    public override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collection.count
    }
    
    public override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let con = ImageViewPageController.controller(collection, index: indexPath.row)
        self.presentViewController(con, animated: true) { () -> Void in
        }
    }
    
    public override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! UICollectionViewCell
        
        if let cell = cell as? ImageCollectionViewCell {
            let image = collection.image(indexPath.row)
            if let image = image {
                cell.setImage(image)
            }
        }
        
        return cell
    }
    
    public func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: cellSize, height: cellSize + 1)
    }
    
}

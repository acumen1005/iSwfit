//
//  ACPhotoWall.swift
//  ACPhotoWall
//
//  Created by acumen on 16/12/2.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

let CELL_COLLECTIONVIEW_IDENRIFIER: String = "ACPhotoWallCell"

class ACPhotoWallController: UIViewController {

    var collectionView: UICollectionView?
    var imageCount: Int?
    var imageNames: NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.bounds = CGRect(x: 0, y: 0, width: Layout.SCREEN_WIDTH, height: Layout.SCREEN_HEIGHT)
        
        configData()
        configSubViews()
    }
    
    // MARK: - config
    
    func configData() {
        
        imageNames = NSMutableArray()
        for index in 0...1 {
            imageNames?.add("image_\(8)")
        }
    }
    
    func configSubViews() {
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = Layout.PT3
        flowLayout.minimumLineSpacing = Layout.PT3
        let cwidth = Layout.SCREEN_WIDTH - Layout.PT10 * 2.0
        let fwidth = (cwidth - Layout.PT3 * 2.0)/3.0
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: Layout.PT5, bottom: 0, right: Layout.PT5)
        flowLayout.itemSize = CGSize(width: fwidth, height: fwidth)
        
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: Layout.SCREEN_WIDTH, height: cwidth * 1.5), collectionViewLayout: flowLayout)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.green
        
        collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: CELL_COLLECTIONVIEW_IDENRIFIER)
        
        self.view.addSubview(collectionView!)
    }
    
    
    func  renderImage(name: String) -> UIImage {
        
        let image_jpg = UIImage(named: "\(name).jpg")
        let image_png = UIImage(named: "\(name)")
        
        return image_png ?? image_jpg!
    }
    
}

extension ACPhotoWallController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.imageNames?.count)!
    }
}

extension ACPhotoWallController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_COLLECTIONVIEW_IDENRIFIER, for: indexPath)
        
//        let tmp = cell.contentView.viewWithTag(100)
//        
//        if tmp == nil {
//            
//            let image = renderImage(name: self.imageNames?.object(at: indexPath.row) as! String)
//            let imageView = UIImageView(image: image)
//            imageView.frame = cell.bounds
//            imageView.tag = 100
////            cell.addSubview(imageView)
//        }
        
        cell.backgroundColor = UIColor.blue
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let photoGalleryController = ACPhotoGalleryController()
        
    }
}

//
//  ViewController.swift
//  ACPhotoWall
//
//  Created by acumen on 16/12/2.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

class ViewController: ACBaseViewController {

    var collectionView: UICollectionView?
    var imageCount: Int?
    var imageNames: NSMutableArray?
    var flowLayout: UICollectionViewFlowLayout?
    var focusImageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        configData()
        configSubViews()
    }
    
    func configData() {
        
        imageNames = NSMutableArray()
        for index in 0...8 {
            imageNames?.add("image_\(index)")
        }
    }
    
    func configSubViews() {
        
        flowLayout = UICollectionViewFlowLayout()
        flowLayout?.minimumInteritemSpacing = Layout.PT3
        flowLayout?.minimumLineSpacing = Layout.PT3
        let cwidth = Layout.SCREEN_WIDTH - Layout.PT10 * 2.0
        let fwidth = (cwidth - Layout.PT3 * 2.0)/3.0
        flowLayout?.itemSize = CGSize(width: fwidth, height: fwidth)
        
        collectionView = UICollectionView(frame: CGRect(x: Layout.PT10, y: Layout.PT10, width: cwidth, height: cwidth * 1.5), collectionViewLayout: flowLayout!)
        collectionView?.delegate = self
        collectionView?.dataSource = self
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: CELL_COLLECTIONVIEW_IDENRIFIER)
        
        self.navigationItem.leftBarButtonItem = nil
        self.view.addSubview(collectionView!)
    }
    
    func renderImage(name: String) -> UIImage {
        
        let image_jpg = UIImage(named: "\(name).jpg")
        let image_png = UIImage(named: "\(name)")
        
        return image_png ?? image_jpg!
    }
    
    func renderAnimationImageView(name: String, frame: CGRect) -> UIImageView{
        
        let imageView = UIImageView(frame: frame)
        imageView.image = UIImage(named: name)
        
        return imageView
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return (self.imageNames?.count)!
    }
}

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_COLLECTIONVIEW_IDENRIFIER, for: indexPath)
        
        let tmp = cell.contentView.viewWithTag(UnityData.IMAGE_TAG)
        
        if tmp == nil {
        
            let image = renderImage(name: self.imageNames?.object(at: indexPath.row) as! String)
            let imageView = UIImageView(image: image)
            imageView.frame = cell.bounds
            imageView.tag = UnityData.IMAGE_TAG
            cell.addSubview(imageView)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CELL_COLLECTIONVIEW_IDENRIFIER, for: indexPath)
//        
//        let tmp = cell.contentView.viewWithTag(UnityData.IMAGE_TAG)
//        let windowframe = Layout.APPDELEGATE_WINDOW.convert((focusImageView?.frame)!, from: cell.contentView)
//        
//        let imageName = self.imageNames?.object(at: indexPath.row) as! String
//        let animationImageView = renderAnimationImageView(name:imageName, frame: windowframe)
        
//        Layout.APPDELEGATE_WINDOW.addSubview(animationImageView)
    }
}



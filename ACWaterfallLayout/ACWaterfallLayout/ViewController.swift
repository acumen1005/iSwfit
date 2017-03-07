//
//  ViewController.swift
//  ACWaterfallLayout
//
//  Created by acumen on 17/3/3.
//  Copyright © 2017年 acumen. All rights reserved.
//

import UIKit

struct Layout {
    static let SCREEN_WIDTH = UIApplication.shared.windows.first?.bounds.size.width
    static let SCREEN_HEIGHT = UIApplication.shared.windows.first?.bounds.size.height
    static let SPACING_5: CGFloat = 5.0
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ACCollectionViewLayoutDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    var indexPaths: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collectionView.delegate = self
        collectionView.dataSource = self
        ACImageCollectionViewCell.registerNib(collectionView)
        let layout = ACCollectionViewLayout()
        layout.delegate = self
        layout.numberOfRow = 2
        collectionView.collectionViewLayout = layout
        
        var images: [UIImage] = []
        for _ in 0 ..< 30 {
            let index = arc4random_uniform(4)
            images.append(UIImage(named: "op\(index).jpg")!)
        }
        indexPaths = images
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return indexPaths.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ACImageCollectionViewCell",
            for: indexPath) as! ACImageCollectionViewCell
        cell.acImageView.image = indexPaths[indexPath.row]
        return cell
    }
    
    func sizeForItem(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, indexPath: IndexPath) -> CGSize {
        return indexPaths[indexPath.row].size
    }
}

extension UIView {
    class func nib() -> UINib {
        return UINib(nibName: "\(self.classForCoder())", bundle: nil)
    }
    
    class  func registerNib(_ collectionView: UICollectionView) {
        collectionView .register(self.nib(), forCellWithReuseIdentifier: "\(self.classForCoder())")
    }
}

extension UICollectionViewDelegate {
    
}

extension UICollectionViewDataSource {
    
}

extension ACCollectionViewLayoutDelegate {
    
}

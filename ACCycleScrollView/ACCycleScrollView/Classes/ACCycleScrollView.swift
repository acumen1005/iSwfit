//
//  ACCycleScrollView.swift
//  ACCycleScrollView
//
//  Created by acumen on 16/11/28.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit


class ACCycleScrollView: UIView, UIScrollViewDelegate {

    // MRAK: - prioprty
    var scrollView: UIScrollView?
    var pageControl: UIPageControl?
    var appDelegate: UIApplication? {
        get {
            return UIApplication.shared
        }
    }
    var images: NSArray?
    var timer: Timer?
    var indexPage = 0
    var timeInterval: TimeInterval?
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(frame: CGRect, images: NSArray) {
        self.init(frame:frame, images: images, timeInterval:0)
    }
    
    public init(frame: CGRect, images: NSArray, timeInterval: TimeInterval){
        super.init(frame: frame)
        
        self.images = images
        self.timeInterval = timeInterval
        
        _configSubViews()
        _configImages()
        _configData()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - private methods

    private func _configData() {
        
        indexPage = 0
        _resetTimer()
    }
    
    private func _stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    private func _resetTimer() {
        _stopTimer()
        timer = Timer(timeInterval: self.timeInterval!, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .commonModes)
    }
    
    private func _configSubViews() {
        
        scrollView = UIScrollView(frame: self.frame)
        scrollView?.delegate = self
        scrollView?.isPagingEnabled = true
        scrollView?.showsHorizontalScrollIndicator = false
        
        scrollView?.addObserver(self, forKeyPath: "contentOffset", options: [.new,.old], context: nil)
        
        let controlY = (scrollView?.frame.size.height)! - 20.0 + 64
        let rect = CGRect(x: 0, y: controlY, width: SCREEN_WIDTH, height: 20)
        pageControl = UIPageControl(frame: rect)
        pageControl?.frame = rect
        pageControl?.numberOfPages = self.images!.count
        pageControl?.backgroundColor = UIColor.clear
        pageControl?.currentPageIndicatorTintColor = UIColor.white
        pageControl?.currentPage = 0
        pageControl?.layer.zPosition = 1000
        
        appDelegate?.keyWindow?.addSubview(pageControl!)
        self.addSubview(scrollView!)
    }
    
    private func _configImages() {
        
        var x: CGFloat = 0.0
        
        for imageName in self.images! {
            
            let imageView = _renderImageViewWithImageName(imageName: imageName as! NSString);
            imageView.frame = CGRect(x: x, y: 0, width: SCREEN_WIDTH, height: (scrollView?.frame.size.height)!)
            x = x + SCREEN_WIDTH
            
            scrollView?.addSubview(imageView)
        }
        
        scrollView?.contentSize = CGSize(width: x , height: (scrollView?.frame.size.height)!)
        
    }
    
    private func _renderImageViewWithImageName(imageName: NSString) -> UIImageView {
        
        return UIImageView(image: UIImage(named: imageName as String))
    }
    
    //  MARK: - public methods
    
    func timerAction() {
        
        scrollView?.setContentOffset(CGPoint(x: (SCREEN_WIDTH * CGFloat(indexPage)), y: 0), animated: true)
        
        indexPage = indexPage + 1
        indexPage = indexPage%(self.images?.count)!
    }
    
    // MARK: - KVO
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        if "contentOffset" == keyPath {
            
            let offset = change?[.newKey] as! CGPoint
            let x = offset.x
            indexPage = Int(x/SCREEN_WIDTH)
                
            pageControl?.currentPage = indexPage
        }
    }
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        _stopTimer()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        _resetTimer()
    }
}

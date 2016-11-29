//
//  ACCycleScrollView.swift
//  ACCycleScrollView
//
//  Created by acumen on 16/11/28.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit


typealias completionClosure = (_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void

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
    var imageViews: NSMutableArray?
    var timer: Timer?
    var indexPage = 0
    var timeInterval: TimeInterval?

    // placeholder image
    var placeholder: UIImage?
    
    // MARK: - life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public convenience init(frame: CGRect, images: NSArray) {
        self.init(frame:frame, images: images, timeInterval: 100000)
    }
    
    public convenience init(frame: CGRect, images: NSArray, timeInterval: TimeInterval){
        self.init(frame:frame, images: images, timeInterval:timeInterval, placeholder:UIImage(named: "loading")!)
    }
    
    public init(frame: CGRect, images: NSArray, timeInterval: TimeInterval, placeholder: UIImage) {
        super.init(frame: frame)
        
        self.images = images
        self.timeInterval = timeInterval
        self.placeholder = placeholder
        
        _configSubViews()
        _routeImageAction(images: self.images!)
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
        scrollView?.backgroundColor = UIColor.lightGray
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
        
        self.imageViews = NSMutableArray()
        for _ in self.images! {
            self.imageViews!.add(UIImageView())
        }
    
        appDelegate?.keyWindow?.addSubview(pageControl!)
        self.addSubview(scrollView!)
    }
    
    private func _configLocalImages(images: NSArray) {
        
        var x: CGFloat = 0.0
        for (index, imageName) in self.images!.enumerated() {
            let tmpImageView = self.imageViews?[index] as! UIImageView
            tmpImageView.frame = CGRect(x: x, y: 0, width: SCREEN_WIDTH, height: (self.scrollView?.frame.size.height)!)
            x = x + SCREEN_WIDTH
            
            tmpImageView.image = self._renderImageWithLocalImage(imageName: imageName as! NSString);
            self.scrollView?.addSubview(tmpImageView)
        }
        
        scrollView?.contentSize = CGSize(width: x , height: (scrollView?.frame.size.height)!)
    }
    
    
    private func _configNetworkImages(images: NSArray) {
        
        var x: CGFloat = 0.0
        for (index,imageUrl) in self.images!.enumerated() {
                
            let tmpImageView = self.imageViews?[index] as! UIImageView
            tmpImageView.image = self.placeholder
            tmpImageView.frame = CGRect(x: x, y: 0, width: SCREEN_WIDTH, height: (self.scrollView?.frame.size.height)!)
            x = x + SCREEN_WIDTH
            
            DispatchQueue.global().async {
                self._renderImageViewWithNetworkImage(imageUrl: imageUrl as! NSString, compation:{(data: Data?) -> Void in
                    
                    DispatchQueue.main.async {
                        tmpImageView.image = UIImage(data: data!)
                        self.scrollView?.addSubview(tmpImageView)
                    }
                })
            }

        }
        
        scrollView?.contentSize = CGSize(width: x , height: (scrollView?.frame.size.height)!)
    }
    
    private func _renderImageWithLocalImage(imageName: NSString) -> UIImage {
        
        return UIImage(named: imageName as String)!
    }
    
    
    private func _renderImageViewWithNetworkImage(imageUrl: NSString, compation:@escaping ((Data?) -> Void)) -> Void {
        
        assert(imageUrl.hasPrefix("http"), "the parameter is't a url")
        
        if ACImageCache.shared.isExist(forKey: imageUrl) {
            
            let image = ACImageCache.shared.getImageCacheFromMomery(forKey: imageUrl)
            
            compation(image)
            return ;
        }
        
        _getNetworkImage(url: imageUrl, closure: {
            (data: Data?, repsonse: URLResponse?, error: Error?) -> Void in
            
            if((error) == nil) {
                ACImageCache.shared.setImageCache2MomeryWithData(data!, forKey: imageUrl)
                compation(data!)
            }
            else {
                
            }
        })
    }
    
    func _routeImageAction(images: NSArray) {
        
        let str = images[0] as! NSString
        if(!str.hasPrefix("http")) {
            _configLocalImages(images: images)
        }
        else {
            _configNetworkImages(images: images)
        }
    }
    
    func _getNetworkImage(url: NSString, closure: @escaping (Data?, URLResponse?, Error?) -> Void) -> Void {
        
        let session = URLSession.shared
        
        let request = URLRequest(url: URL(string: url as String)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 15.0)
        
        let dataTask = session.dataTask(with: request, completionHandler:closure)
        
        dataTask.resume()
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

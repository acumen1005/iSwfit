//
//  ACBrowser.swift
//  ACBrowser
//
//  Created by acumen on 16/12/20.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit
import WebKit

class ACBrowserViewController: UIViewController {

    private var webView: WKWebView
    private let toolBar: UIToolbar
    private var searchBar: UISearchBar?
    private var titleLabel: UILabel
    
    init(url: URL) {
        self.webView = WKWebView(frame: CGRect(x: 0, y: NAV_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - TOOLBAR_HEIGHT))
        self.toolBar = UIToolbar(frame: CGRect(x: 0, y: SCREEN_HEIGHT - TOOLBAR_HEIGHT - NAV_HEIGHT, width: SCREEN_WIDTH, height: TOOLBAR_HEIGHT))
        self.titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: 30))
        self.titleLabel.font = UIFont.systemFont(ofSize: 12)
        self.titleLabel.textAlignment = .center
        super.init(nibName:nil, bundle:nil)
        self.webView.load(self._request(url: url))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func _request(url: URL) -> URLRequest {
        let request = URLRequest(url: url)
        return request
    }
    
    func setupToolBar() {
        self.view.addSubview(self.toolBar)
        
        let goBack = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onClickToGoBack))
        let goFront = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(onClickToGoFront))
        let marker = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(pressntMarkerView))
        let history = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(pressntHistoryView))
        let blank1 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let blank2 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let blank3 = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        self.toolBar.backgroundColor = UIColor.white
        self.toolBar.setItems([goBack, blank1, goFront, blank2, marker, blank3, history], animated: true)
        
        self.view.addSubview(self.toolBar)
    }
    
    func setupSearchBar() {
        searchBar = UISearchBar(frame: CGRect.zero)
        searchBar?.barStyle = .black
        searchBar?.delegate = self
        searchBar?.searchBarStyle = .default
        self.navigationItem.titleView = searchBar!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        setupToolBar()
        setupSearchBar()
        
        self.view.addSubview(self.webView)
        
        self.webView.scrollView.addObserver(self, forKeyPath: "contentOffset", options: .new, context: nil)
        self.searchBar?.text = "baidu.com"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onClickToGoBack() {
        
    }
    
    func onClickToGoFront() {
        
    }
    
    func pressntMarkerView() {
        
    }
    
    func pressntHistoryView() {
        
    }
    
    func onClick2Cancel() {
        self.searchBar?.endEditing(true)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "contentOffset") {
            var offSet = change?[.newKey] as! CGPoint

            offSet.y = offSet.y - 64
            var progress: CGFloat = 0.0
            if (offSet.y > -64) {
                progress = (offSet.y + 64)/40;
                progress = min(progress, 1.0)
            }else{
                progress = 0;
            }
            
            let scale = 1 - 0.4 * progress
            let alpha = 1 - progress
            self.searchBar?.alpha = alpha
            self.titleLabel.alpha = progress
            
            if alpha == 0 {
                self.navigationItem.titleView = self.titleLabel
            } else {
                self.navigationItem.titleView = self.searchBar
            }
            
            let navHeight: CGFloat = 44.0
            let navOffSetY = -0.4 * navHeight * progress
            let searchOffsetY = navHeight * 0.2 * progress;
            let scaleTran = CGAffineTransform(scaleX: scale, y: scale);
            let transTran = CGAffineTransform(translationX: 0, y: searchOffsetY)
            self.searchBar?.transform = scaleTran.concatenating(transTran)
            self.navigationController?.navigationBar.transform = CGAffineTransform(translationX: 0,y: navOffSetY);
        } else if keyPath == "title" {
            self.titleLabel.text = change?[.newKey] as! String?
        }
    }
}

extension ACBrowserViewController: UISearchBarDelegate {
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        searchBar.endEditing(true)
    }
}

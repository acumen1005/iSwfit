//
//  ACImageDownload.swift
//  ACCycleScrollView
//
//  Created by acumen on 16/11/29.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

enum ACImageDownloadCacheType {
    case ACImageDownloadCacheDefault
    case ACImageDownloadCacheDish
    case ACImageDownloadCacheMomery
}

class ACImageDownload: NSObject {

    var sessionTask: URLSessionTask?
    var request: URLRequest?
    var sessionConfiguration: URLSessionConfiguration?
    
    override init() {
        super.init()
    }
    
    public convenience init(sessionTask: URLSessionTask, request: URLRequest){
        
        let config = URLSessionConfiguration();
        config.timeoutIntervalForRequest = URLSESSION_TIMEOUT
        
        self.init(sessionTask: sessionTask, request: request, sessionConfiguration: config)
    }
    
    public init(sessionTask: URLSessionTask, request: URLRequest, sessionConfiguration: URLSessionConfiguration){
        
        self.sessionTask = sessionTask
        self.request = request
        self.sessionConfiguration = sessionConfiguration
    }
    
}

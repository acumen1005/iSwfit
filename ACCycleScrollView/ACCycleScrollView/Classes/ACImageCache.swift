//
//  ACImageCache.swift
//  ACCycleScrollView
//
//  Created by acumen on 16/11/29.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

enum ACImageCachePolicy: Int {
    case ACImageCachePolicyDefault = 0
    case ACImageCachePolicyDisk = 1
    case ACImageCachePolicyMemory = 2
}

class ACImageCache: NSObject {
    
    var imageDisk: NSDictionary?
    var imageMomery: NSCache<NSString, AnyObject>?
    var fileManager = FileManager.default
    
    static let shared: ACImageCache = {
        let instance = ACImageCache()
        return instance
    }()
    
//    func setImageCache2Disk(_ object: UIImage, forKey: NSString) -> Void {
//        
//        let data = UIImageJPEGRepresentation(object,CACHE_IMAGE_QUALITY)
//        if !fileManager.fileExists(atPath: CACHE_IMAGE_PATH) {
//            print("file dose not exist")
//            
//            do {
//                try fileManager.createDirectory(atPath: CACHE_IMAGE_PATH, withIntermediateDirectories: true, attributes: nil)
//                
//            } catch _ {}
//            
//        } else {
//            fileManager.createFile(atPath: CACHE_IMAGE_PATH, contents: data!, attributes: [:])
//        }
//    }
//
//    func getImageCacheFromDisk(forKey: NSString) -> Data {
//        
//        if !fileManager.fileExists(atPath: CACHE_IMAGE_PATH) {
//            print("file dose not exist")
//            return Data()
//        } else {
//            return fileManager.contents(atPath: CACHE_IMAGE_PATH)!
//        }
//    }
    
    func setImageCache2MomeryWithImage(_ object: UIImage, forKey: NSString) -> Void {
        
        let data = UIImageJPEGRepresentation(object,CACHE_IMAGE_QUALITY)
        ACImageCache.shared.imageMomery?.setObject(data as AnyObject, forKey: forKey)
    }
    
    func setImageCache2MomeryWithData(_ object: Data, forKey: NSString) -> Void {
        
        ACImageCache.shared.imageMomery?.setObject(object as AnyObject, forKey: forKey)
    }
    
    func getImageCacheFromMomery(forKey: NSString) -> Data {
        
        if isExist(forKey: forKey) {
            return (ACImageCache.shared.imageMomery?.object(forKey: forKey))! as! Data
        }
        else {
            return Data()
        }
    }
    
    // 1. judge the momery first, if don't exit, then judge the disk
    
    func isExist(forKey: NSString) -> Bool {
        let cache = ACImageCache.shared.imageMomery?.object(forKey: forKey)
        
        
        return cache != nil
    }

}

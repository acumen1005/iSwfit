//
//  Data.swift
//  ACCycleScrollView
//
//  Created by acumen on 16/11/29.
//  Copyright © 2016年 acumen. All rights reserved.
//

import Foundation
import UIKit

let URLSESSION_TIMEOUT: TimeInterval = TimeInterval(15.0)

let DOCUMENT_PATH = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
let CACHE_IMAGE_PATH = String.init(format: "%@/ACCycleScrollView.data", DOCUMENT_PATH)
let CACHE_IMAGE_QUALITY = CGFloat(0.9)

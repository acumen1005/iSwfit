//
//  conts.swift
//  ACSearchViewController
//
//  Created by acumen on 16/12/1.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit

let DOCUMENT_PATH = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]
let CACHE_HISTORY_PATH = String.init(format: "%@/HistorySearch.data", DOCUMENT_PATH)

let HISTORY_COUNT: Int = 4
let HISTORY_COUNT_MAX: Int = 10

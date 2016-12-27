//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by acumen on 16/12/27.
//  Copyright © 2016年 acumen. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        
        let inputItem = self.extensionContext?.inputItems.first as! NSExtensionItem
        
        var isEmpty = false
        if let attachments:[NSItemProvider] = inputItem.attachments as! [NSItemProvider]? {
            
            if let item = attachments.first ,item.hasItemConformingToTypeIdentifier("public.url") {
                item.loadItem(
                    forTypeIdentifier: "public.url",
                    options: nil,
                    completionHandler: { (secureCoding, error) in
                        if let url = secureCoding as? URL {
                            let userDefault = UserDefaults(suiteName: "group.extension.demo")
                            userDefault?.set(url.absoluteString, forKey: "com.acumen.share.url")
                            userDefault?.synchronize()
                            isEmpty = true
                            
                            self.extensionContext?.completeRequest(returningItems: [item], completionHandler: nil)
                            
                            self.extensionContext?.open(URL(string: "todayextension://test")!, completionHandler: nil)
                        }
                })
            }
        }
        
        if let userInfo = inputItem.userInfo {
            print(userInfo)
        }
        
        if !isEmpty {
            self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
        }
    }

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }

}

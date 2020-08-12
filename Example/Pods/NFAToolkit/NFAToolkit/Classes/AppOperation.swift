//
//  AppOperation.swift
//  FBSnapshotTestCase
//
//  Created by 聂飞安 on 2019/11/25.
//

/*
    应用内工具
 */
import UIKit

open class AppOperation {

    //MARK:  复制文字到手机黏贴板
    open class func pasteboardCopy(_ copyString : String ){
        UIPasteboard.general.string = copyString
    }
    
    //MARK: 应用内打开
    open class func openURL(_ urlString : String) -> Bool{
        if let url = URL(string: urlString) {
            if UIApplication.shared.canOpenURL(url as URL) {
                UIApplication.shared.openURL(url)
                return true
            }
        }
        return false
    }
    
    
    open class func openWriteReview(_ appId : String)
    {
      let _ = openURL("itms-apps://itunes.apple.com/cn/app/\(appId)?mt=8&action=write-review")
    }
//    itms-apps://itunes.apple.com/cn/app/1473778999?mt=8&action=write-review
}

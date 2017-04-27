//
//  Library.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class Library {
    static func alert(title: String = "錯誤", message: String, needButton: Bool) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if needButton {
            alert.addAction(UIAlertAction(title: "確定", style: .cancel, handler: nil))
        }
        return alert
    }
    
    
    
    //傳送Noti通知
    static func sentNoti(notiName: String) -> (){
        let notiname = Notification.Name(rawValue: notiName)
        NotificationCenter.default.post(name: notiname, object: nil)
    }

    

}

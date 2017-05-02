//
//  SideMenuTableViewController.swift
//  FinalProject
//
//  Created by SUNG HAO LIN on 2017/4/26.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class SideMenuTableViewController: UITableViewController{


    @IBOutlet weak var sideUserImage: UIImageView!
    @IBOutlet weak var sideUserNameLabel: UILabel!
    
    let mm = MaindataManager.shareInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隔線消失
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        //頭像設置
        //sideUserImage.layer.cornerRadius = sideUserImage.frame.width / 2
        sideUserImage.contentMode = .scaleAspectFit
        //sideUserImage.clipsToBounds = true
        sideUserImage.image = UIImage(named: "goblinLogo")
        
//        if let tryImage = Auth.userInfoDic["file_location"]!["medium"] as? Dictionary<String,String> {
//            if let getImageUrlString = tryImage["url"] {
//                mm.getImage(urlString: getImageUrlString, completion: { (image) in
//                    self.sideUserImage.image = image
//                })
//                
//                
//            }
//        }
        
    }

    
    
    //發送個人資料轉場通知
    @IBAction func editUserButton(_ sender: UIButton) {
       Library.sentNoti(notiName: "ToEditInfo")
    }
    
    
    
    //發送聯絡官方轉場通知
    @IBAction func sendEmailButton(_ sender: UIButton) {
        Library.sentNoti(notiName: "ToConncetionUs")
    }
    
    
    
    //發送學院規章轉場通知
    @IBAction func settingSystemButton(_ sender: UIButton) {
        Library.sentNoti(notiName: "ToSetting")
    }
    
    //發送線上客服轉場通知
    @IBAction func onlineGMButton(_ sender: UIButton) {
        Library.sentNoti(notiName: "ToOnlineGm")
    }
    
    
    
    //發送登出通知
    @IBAction func logoutButton(_ sender: UIButton) {
        //登出帳號
        Library.sentNoti(notiName: "LogotAccount")
    }
    
    
    //
}

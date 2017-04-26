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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //隔線消失
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //頭像設置
        sideUserImage.layer.cornerRadius = sideUserImage.bounds.width / 2
        sideUserImage.contentMode = .scaleAspectFill
        sideUserImage.clipsToBounds = true
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
    
    
    
    //發送登出通知
    @IBAction func logoutButton(_ sender: UIButton) {
        //登出帳號
        Library.sentNoti(notiName: "LogotAccount")
    }
    
    
    //
}

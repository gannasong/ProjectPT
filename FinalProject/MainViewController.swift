//
//  MainViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var examContainerVew: UIView!
    @IBOutlet weak var lessonContainerView: UIView!
    
    //sideMenu
    
    @IBOutlet weak var sideMenuView: UIView!
    @IBOutlet weak var leadingContain: NSLayoutConstraint!
    var sideMenuShowing = false
    
//    var maindata: Maindata!
    var id: String!
    var row: Int!
    
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //預設leading
        leadingContain.constant = -(UIScreen.main.bounds.width * 0.5 + 10)
        //增加側邊的陰影
        sideMenuView.layer.shadowOpacity = 1
        //增加陰影長度
        sideMenuView.layer.shadowRadius = 6
        
        //接收轉場通知-個人資訊01
        let notiInfoButton = Notification.Name("ToEditInfo")
        NotificationCenter.default.addObserver(self, selector: #selector(goEditInfoNoti(noti:)), name: notiInfoButton, object: nil)
        //接收轉場通知-聯絡我們02
        let notiConnectButton = Notification.Name("ToConncetionUs")
        NotificationCenter.default.addObserver(self, selector: #selector(goConnectionNoti(noti:)), name: notiConnectButton, object: nil)
        //接收轉場通知-系統設定03
        let notiSettingButton = Notification.Name("ToSetting")
        NotificationCenter.default.addObserver(self, selector: #selector(goSettingNoti(noti:)), name: notiSettingButton, object: nil)
        //接收轉場通知-線上客服05
        let notionlineGmButton = Notification.Name("ToOnlineGm")
        NotificationCenter.default.addObserver(self, selector: #selector(goOnlineGmNoti(noti:)), name: notionlineGmButton, object: nil)
        //接收轉場通知-登出帳號04
        let notiLogoutButton = Notification.Name("LogotAccount")
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: notiLogoutButton, object: nil)
        

        // Do any additional setup after loading the view.
        Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
            MaindataManager.shareInstance().callAPI {
                NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(selected(noti:)), name: Notification.Name("selected"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func selected(noti: Notification) {
//        maindata = noti.userInfo!["maindata"] as! Maindata
        id = noti.userInfo!["id"] as! String
        row = noti.userInfo!["row"] as! Int
        
        performSegue(withIdentifier: "Detail", sender: self)
    }
    
    func logout() {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            examContainerVew.isHidden = false
            lessonContainerView.isHidden = true
        } else {
            examContainerVew.isHidden = true
            lessonContainerView.isHidden = false
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let destinationController = segue.destination as! DetailViewController
//            destinationController.maindata = maindata
            destinationController.id = id
            destinationController.row = row
        }
    }
    
    
    @IBAction func testButton(_ sender: UIBarButtonItem) {
//        let order = ["authenticity_token" : Auth.token, "id" : 35, "title" : "手機端測試", "start_date" : "2017-05-05",
//                     "due_date" : "2017-08-10",
//                     "organiser" : "Jay",
//                     "phone" : "0926623688",
//                     "email" : "jexwang@icloud.com", "category" : ["category" : "Android程式"],
//                     "Contestant": []] as [String : AnyObject]
//        let urlString = "https://fathomless-harbor-32460.herokuapp.com/api/v1/games".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
//        if let url = URL(string: urlString) {
//            var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
////            request.addValue(Auth.token, forHTTPHeaderField: "Content-Type")
//            request.httpMethod = "PATCH"
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//            let data = try? JSONSerialization.data(withJSONObject: order, options: [])
//            let task = URLSession.shared.uploadTask(with: request, from: data, completionHandler: { (data, response, error) in
//                if error != nil {
//                    print(error!.localizedDescription)
//                } else {
//                    print("SUCCESS")
//                }
//            })
//            task.resume()
//        }
        
        NotificationCenter.default.post(name: Notification.Name("test"), object: nil)
    }
    

    
    
    @IBAction func openSideMemu(_ sender: UIBarButtonItem) {
        if sideMenuShowing {
            leadingContain.constant = -(UIScreen.main.bounds.width * 0.5 + 10)
            //增加動畫效果
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                //告訴view要執行位置改變，立即實現佈局
                self.view.layoutIfNeeded()
            }, completion: nil)
        } else {
            leadingContain.constant = 0
            
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        //變更sideMemu狀態
        sideMenuShowing = !sideMenuShowing
    }
    
    
    //點選空白會sidemenu會收回-ok
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if sideMenuShowing {
            leadingContain.constant = -(UIScreen.main.bounds.width * 0.5 + 10)
            //增加動畫效果
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
                //告訴view要執行位置改變，立即實現佈局
                self.view.layoutIfNeeded()
            }, completion: nil)
            sideMenuShowing = false
        }
    }

    //sideMenu-接收消息要做的事
    //接收到個人資訊要做的事01
    func goEditInfoNoti(noti:Notification) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.performSegue(withIdentifier: "toEditInfo", sender: nil)
        }
    }
    
    //接收到聯絡我們要做的事02
    func goConnectionNoti(noti:Notification) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.performSegue(withIdentifier: "toConncetionUs", sender: nil)
        }
    }
    
    //接收到系統設丟要做的事03
    func goSettingNoti(noti:Notification) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            self.performSegue(withIdentifier: "toSetting", sender: nil)
        }
    }
    
    //接收通知轉場05
    func goOnlineGmNoti(noti:Notification) {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: { 
            self.view.layoutIfNeeded()
        }) { _ in
            self.performSegue(withIdentifier: "toOnlineGm", sender: nil)
        }
    }
    
    /*
     //登出04-登出帳號並轉場
     func gologoutNoti(noti:Notification) {
     UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut, animations: {
     self.view.layoutIfNeeded()
     }) { _ in
     performSegue(withIdentifier: "", sender: nil)
     }
     }
     
     */

    
    
    
    
    
    
}



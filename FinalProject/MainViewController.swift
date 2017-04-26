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
    
//    var maindata: Maindata!
    var id: String!
    var row: Int!
    
    var token: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        MaindataManager.shareInstance().callAPI {
            NotificationCenter.default.post(name: Notification.Name("reload"), object: nil)
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
        let order = ["authenticity_token" : "Wzyhl2m2UPIo+oMdJ6bmlh8uz08z40cSJCs42Dcbuxf9TSfcPf7nIHEIW8hprBi0ZN50RoekD1xWZvtNutQjhg==", "id" : 35, "title" : "手機端測試", "start_date" : "2017-05-05",
                     "due_date" : "2017-08-10",
                     "organiser" : "Jay",
                     "phone" : "0926623688",
                     "email" : "jexwang@icloud.com", "category" : ["category" : "Android程式"],
                     "Contestant": []] as [String : AnyObject]
        let urlString = "https://fathomless-harbor-32460.herokuapp.com/games/35".addingPercentEncoding(withAllowedCharacters: CharacterSet.urlPathAllowed)!
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
//            request.addValue(Auth.token, forHTTPHeaderField: "Content-Type")
            request.httpMethod = "PATCH"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            let data = try? JSONSerialization.data(withJSONObject: order, options: [])
            let task = URLSession.shared.uploadTask(with: request, from: data, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    print("SUCCESS")
                }
            })
            task.resume()
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

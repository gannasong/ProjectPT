//
//  DetailViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/24.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit
import SVProgressHUD

class DetailViewController: UIViewController {
    
    let mm = MaindataManager.shareInstance()
    var id: String!
    var row: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func joinButton(_ sender: UIButton) {
        let maindata = mm.getArray(id: id)[row]
        if let url = URL(string: "https://fathomless-harbor-32460.herokuapp.com/api/v1/games/\(maindata.id)/attend?auth_token=\(Auth.token!)") {
            var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    SVProgressHUD.showSuccess(withStatus: "已完成")
                    SVProgressHUD.dismiss(withDelay: 1.5)
                }
            })
            task.resume()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case "DetailTableView":
            let destinationController = segue.destination as! DetailTableViewController
            destinationController.id = id
            destinationController.row = row
        case "Students":
            let destinationController = segue.destination as! StudentsCollectionViewController
            destinationController.id = id
            destinationController.row = row
        default:
            break
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

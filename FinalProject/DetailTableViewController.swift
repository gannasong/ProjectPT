//
//  DetailTableViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class DetailTableViewController: UITableViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var creditLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var dueLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    let mm = MaindataManager.shareInstance()
//    var maindata: Maindata!
    var id: String!
    var row: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let maindata = mm.getArray(id: id)[row]
        
        let url = maindata.image["medium"] as! Dictionary<String, String>
        mm.getImage(urlString: url["url"]!) { (image) in
            self.imageView.image = image
        }
        
        
        startLabel.text = maindata.start_date
        dueLabel.text = maindata.due_date
        teacherLabel.text = maindata.organiser
        phoneLabel.text = maindata.phone
        emailLabel.text = maindata.email
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return view.frame.width * 0.8
        } else {
            return tableView.rowHeight
        }
    }

}

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
    @IBOutlet weak var test_idLabel: UILabel!
    @IBOutlet weak var test_peopleLabel: UILabel!
    @IBOutlet weak var start_dateLabel: UILabel!
    @IBOutlet weak var due_dateLabel: UILabel!
    @IBOutlet weak var test_dateLabel: UILabel!
    @IBOutlet weak var test_costLabel: UILabel!
    @IBOutlet weak var quota_placesLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
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
        
        
        test_idLabel.text = maindata.test_id
        test_peopleLabel.text = maindata.test_people
        start_dateLabel.text = maindata.start_date
        due_dateLabel.text = maindata.due_date
        test_dateLabel.text = maindata.test_date
        test_costLabel.text = maindata.test_cost
        quota_placesLabel.text = maindata.quota_places
        contentLabel.text = maindata.content
        
        tableView.estimatedRowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return view.frame.width * 0.8
        } else {
            return UITableViewAutomaticDimension
        }
    }

}

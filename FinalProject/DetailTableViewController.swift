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
    @IBOutlet weak var titleLabel: UILabel!
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
        
        let maindata = mm.getArrat(id: id)[row]
        
        titleLabel.text = maindata.title
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

}

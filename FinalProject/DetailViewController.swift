//
//  DetailViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/24.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var studentsButton: UIButton!
    
    let mm = MaindataManager.shareInstance()
    var id: String!
    var row: Int!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        studentsButton.setTitle("報名學生(\(mm.getArrat(id: id)[row].contestant.count))", for: .normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

//
//  ListTableViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class ExamListTableViewController: UITableViewController {
    
    @IBOutlet weak var enlightenmentCollectionView: UICollectionView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var iOSCollectionView: UICollectionView!
    @IBOutlet weak var androidCollectionView: UICollectionView!
    @IBOutlet weak var webCollectionView: UICollectionView!
    
    let mm = MaindataManager.shareInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
        enlightenmentCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        gameCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        iOSCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        androidCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        webCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
        
//        let collectionFlow = UICollectionViewFlowLayout
//        collectionFlow.itemSize = CGSize(width: 10, height: 10)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(test), name: Notification.Name("test"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func test() {
        let indexPath = IndexPath(row: 0, section: 2)
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

    func reload() {
        DispatchQueue.main.async {
            self.enlightenmentCollectionView.reloadData()
            self.gameCollectionView.reloadData()
            self.iOSCollectionView.reloadData()
            self.androidCollectionView.reloadData()
            self.webCollectionView.reloadData()
        }
    }
    
}

extension ExamListTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mm.getCount(id: collectionView.restorationIdentifier!)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
        let maindata = mm.getArray(id: collectionView.restorationIdentifier!)[indexPath.row]
        
        let url = maindata.image["medium"] as! Dictionary<String, String>
        mm.getImage(urlString: url["url"]!) { (image) in
            DispatchQueue.main.async {
                cell.logoImageView.image = image
            }
        }
        
        cell.titleLabel.text = maindata.title
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let maindata = mm.getArrat(id: collectionView.restorationIdentifier!)[indexPath.row]
//        NotificationCenter.default.post(name: Notification.Name("selected"), object: nil, userInfo: ["maindata" : maindata])
        let id = collectionView.restorationIdentifier!
        let row = indexPath.row
        NotificationCenter.default.post(name: Notification.Name("selected"), object: nil, userInfo: ["id" : id, "row" : row])
    }
    
}

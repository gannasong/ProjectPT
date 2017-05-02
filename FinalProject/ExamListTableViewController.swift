//
//  ListTableViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit
import SVProgressHUD

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
        
        let size = view.frame.width * 0.6
        
        enlightenmentCollectionView.frame.size.height = size + 20
        gameCollectionView.frame.size.height = size + 20
        iOSCollectionView.frame.size.height = size + 20
        androidCollectionView.frame.size.height = size + 20
        webCollectionView.frame.size.height = size + 20
        
        let enlightenmentLayout = enlightenmentCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        enlightenmentLayout.itemSize = CGSize(width: size, height: size)
        let gameCollectionLayout = gameCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        gameCollectionLayout.itemSize = CGSize(width: size, height: size)
        let iOSCollectionLayout = iOSCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        iOSCollectionLayout.itemSize = CGSize(width: size, height: size)
        let androidCollectionLayout = androidCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        androidCollectionLayout.itemSize = CGSize(width: size, height: size)
        let webCollectionLayout = webCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        webCollectionLayout.itemSize = CGSize(width: size, height: size)
        
        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reload() {
        enlightenmentCollectionView.reloadData()
        gameCollectionView.reloadData()
        iOSCollectionView.reloadData()
        androidCollectionView.reloadData()
        webCollectionView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * 0.6 + 20
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 24))
        tempView.image = UIImage(named: "AnfroidBar")
        tempView.contentMode = .scaleAspectFill
        
        let tempLabel = UILabel(frame: CGRect(x: 15, y: 3, width: view.frame.width, height: 20))
        
        tempLabel.textColor = UIColor(red: 157.0/255.0, green: 201.0/255.0, blue: 0/255.0, alpha: 1)
        
        switch section {
        case 0:
            tempLabel.text = "程式啟蒙"
        case 1:
            tempLabel.text = "遊戲程式"
        case 2:
            tempLabel.text = "iOS程式"
        case 3:
            tempLabel.text = "Android程式"
        case 4:
            tempLabel.text = "網頁程式"
        default:
            break
        }
        
        tempView.addSubview(tempLabel)
        
        return tempView
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
        cell.backgroundColor = UIColor.clear
        
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

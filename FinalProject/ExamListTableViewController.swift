//
//  ListTableViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit
import SVProgressHUD

class feedbackData {
    var content = ""
    var feedbackDate = ""
    var mood = 0
    var interactive = 0
    var learn = 3
    
    init(content: String, feedbackDate: String, mood: Int, interactive: Int, learn: Int) {
        self.content = content
        self.feedbackDate = feedbackDate
        self.mood = mood
        self.interactive = interactive
        self.learn = learn
    }
}

class ExamListTableViewController: UITableViewController {
    
//    @IBOutlet weak var enlightenmentCollectionView: UICollectionView!
//    @IBOutlet weak var gameCollectionView: UICollectionView!
//    @IBOutlet weak var iOSCollectionView: UICollectionView!
//    @IBOutlet weak var androidCollectionView: UICollectionView!
//    @IBOutlet weak var webCollectionView: UICollectionView!
    
//    let mm = MaindataManager.shareInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
//        let nib = UINib(nibName: "MainCollectionViewCell", bundle: nil)
//        enlightenmentCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
//        gameCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
//        iOSCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
//        androidCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
//        webCollectionView.register(nib, forCellWithReuseIdentifier: "Cell")
//        
//        let size = view.frame.width * 0.6
//        
//        enlightenmentCollectionView.frame.size.height = size + 20
//        gameCollectionView.frame.size.height = size + 20
//        iOSCollectionView.frame.size.height = size + 20
//        androidCollectionView.frame.size.height = size + 20
//        webCollectionView.frame.size.height = size + 20
//        
//        let enlightenmentLayout = enlightenmentCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        enlightenmentLayout.itemSize = CGSize(width: size, height: size + 140)
//        let gameCollectionLayout = gameCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        gameCollectionLayout.itemSize = CGSize(width: size, height: size + 140)
//        let iOSCollectionLayout = iOSCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        iOSCollectionLayout.itemSize = CGSize(width: size, height: size + 140)
//        let androidCollectionLayout = androidCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        androidCollectionLayout.itemSize = CGSize(width: size, height: size + 140)
//        let webCollectionLayout = webCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
//        webCollectionLayout.itemSize = CGSize(width: size, height: size + 140)
//        
//        NotificationCenter.default.addObserver(self, selector: #selector(reload), name: Notification.Name("reload"), object: nil)
        
        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        
        SVProgressHUD.show(withStatus: "讀取中")
        callAPI {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func reload() {
//        enlightenmentCollectionView.reloadData()
//        gameCollectionView.reloadData()
//        iOSCollectionView.reloadData()
//        androidCollectionView.reloadData()
//        webCollectionView.reloadData()
//    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return view.frame.width * 0.6 + 160
//    }
    
    var feedbackArray: [feedbackData] = []
    
    func callAPI(completion: @escaping () -> Void) {
        let api = "https://fathomless-harbor-32460.herokuapp.com/api/v1/games?auth_token=\(Auth.token!)"
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let content = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject> {
                            if let jsonArray = json["result"] as? NSArray {
                                
                                for i in 0..<jsonArray.count {
                                    if let item = jsonArray[i] as? Dictionary<String, AnyObject> {
                                        if item["name"] as! String == "Ember" {
                                            let feedbackTemp = item["feedback"] as! [Dictionary<String, AnyObject>]
//                                            let feedbackDict = feedbackTemp[0]
                                            for feedbackDict in feedbackTemp {
                                                let feedback = feedbackData(content: feedbackDict["content"]! as! String, feedbackDate: feedbackDict["feedback_date"] as! String, mood: feedbackDict["mood"] as! Int, interactive: feedbackDict["interactive"] as! Int, learn: feedbackDict["learn"] as! Int)
                                                self.feedbackArray.append(feedback)
                                            }   
                                        }
                                    }
                                }
                            }
                        }
                        completion()
                    } catch {
                        print(error)
                    }
                }
            }
        }
        task.resume()
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 32
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let tempView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 24))
        tempView.image = UIImage(named: "AnfroidBar")
        tempView.contentMode = .scaleAspectFill
        
        let tempLabel = UILabel(frame: CGRect(x: 15, y: 3, width: view.frame.width, height: 20))
        
        tempLabel.textColor = UIColor(red: 140.0/255.0, green: 180.0/255.0, blue: 1/255.0, alpha: 1)
        
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedbackArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedbackTableViewCell
        
        cell.containerView.layer.cornerRadius = 10
        
        let feedback = feedbackArray[indexPath.row]
        
        cell.feedbackLabel.text = feedback.content
        cell.dateLabel.text = feedback.feedbackDate
        
        for x in 1...5 {
            if x <= feedback.mood {
                let imageView = cell.viewWithTag(x) as! UIImageView
                imageView.image = UIImage(named: "love_on")
            } else {
                let imageView = cell.viewWithTag(x) as! UIImageView
                imageView.image = UIImage(named: "love_off copy 4")
            }
        }
        
        for y in 6...10 {
            if y <= feedback.interactive + 5 {
                let imageView = cell.viewWithTag(y) as! UIImageView
                imageView.image = UIImage(named: "favorite_on")
            } else {
                let imageView = cell.viewWithTag(y) as! UIImageView
                imageView.image = UIImage(named: "favorite_off copy 4")
            }
            
        }
        
        for z in 11...15 {
            if z <= feedback.learn + 10 {
                let imageView = cell.viewWithTag(z) as! UIImageView
                imageView.image = UIImage(named: "most_viewed_on")
            } else {
                let imageView = cell.viewWithTag(z) as! UIImageView
                imageView.image = UIImage(named: "most_viewed_off copy 4")
            }
            
        }
        
        
        
//        if indexPath.row == 0 {
//            cell.dateLabel.text = "2017/5/10"
////            cell.feedbackLabel.text = "反應敏捷，舉一能反三，能很快的進入各種學習環境。"
//        } else {
//            cell.dateLabel.text = "2017/5/7"
////            cell.feedbackLabel.text = "頭腦靈活，發現小孩子的談話內容都會經過思考，作業也很仔細，很高興有這麼優秀的學生，是個有責任心的孩子。"
////            cell.loveImage.image = UIImage(named: "love_on")
////            cell.starImage.image = UIImage(named: "favorite_on")
//        }
        return cell
    }
    
    
    
}

//extension ExamListTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return mm.getCount(id: collectionView.restorationIdentifier!)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
//        let maindata = mm.getArray(id: collectionView.restorationIdentifier!)[indexPath.row]
//        
//        let url = maindata.image["medium"] as! Dictionary<String, String>
//        mm.getImage(urlString: url["url"]!) { (image) in
//            DispatchQueue.main.async {
//                cell.logoImageView.image = image
//            }
//        }
//        
//        cell.titleLabel.text = maindata.title
//        cell.backgroundColor = UIColor.clear
//        
//        cell.teacherImageView.layer.cornerRadius = 25
//        cell.teacherImageView.contentMode = .scaleAspectFit
//        
//        if collectionView.restorationIdentifier == "Enlightenment" {
//            cell.weekLabel.text = "數分鐘前"
//            cell.likeLabel.text = "0"
//            cell.commentLabel.text = "0"
//        } else {
//            let week = ["一週前", "二週前", "三週前"]
//            let random = Int(arc4random_uniform(3))
//            cell.weekLabel.text = week[random]
//            
//            cell.likeLabel.text = "\(arc4random_uniform(40) + 1)"
//            cell.commentLabel.text = "\(arc4random_uniform(40) + 1)"
//        }
//        
//        return cell
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
////        let maindata = mm.getArrat(id: collectionView.restorationIdentifier!)[indexPath.row]
////        NotificationCenter.default.post(name: Notification.Name("selected"), object: nil, userInfo: ["maindata" : maindata])
//        let id = collectionView.restorationIdentifier!
//        let row = indexPath.row
//        NotificationCenter.default.post(name: Notification.Name("selected"), object: nil, userInfo: ["id" : id, "row" : row])
//    }
//
//}

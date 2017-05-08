//
//  LessonTableViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit
import SVProgressHUD

class Lessondata {
    var id = 0
    var title = ""
    var start_date = ""
    var due_date = ""
    var course_date = ""
    var course_id = ""
    var course_people = ""
    var quota = ""
    var course_cost = ""
    var content = ""
    var image: Dictionary<String, AnyObject> = [:]
    var category: [Dictionary<String, AnyObject>] = []
    
    init(id: Int, title:String, start_date:String,due_date:String, course_date: String, course_id: String, course_people: String, quota: String, course_cost: String, content: String, image: Dictionary<String, AnyObject>, category: [Dictionary<String, AnyObject>]) {
        self.id = id
        self.title = title
        self.start_date = start_date
        self.due_date = due_date
        self.course_date = course_date
        self.course_id = course_id
        self.course_people = course_people
        self.quota = quota
        self.course_cost = course_cost
        self.content = content
        self.image = image
        self.category = category
    }
}

class LessonTableViewController: UITableViewController {

    @IBOutlet weak var enlightenmentCollectionView: UICollectionView!
    @IBOutlet weak var gameCollectionView: UICollectionView!
    @IBOutlet weak var iOSCollectionView: UICollectionView!
    @IBOutlet weak var androidCollectionView: UICollectionView!
    @IBOutlet weak var webCollectionView: UICollectionView!
    
    let mm = MaindataManager.shareInstance()
    var enlightenmentArray: [Lessondata] = []
    var gameArray: [Lessondata] = []
    var iOSArray: [Lessondata] = []
    var androidArray: [Lessondata] = []
    var webArray: [Lessondata] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        NotificationCenter.default.addObserver(self, selector: #selector(getApi), name: Notification.Name("Lesson"), object: nil)
        
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
        enlightenmentLayout.itemSize = CGSize(width: size, height: size + 140)
        let gameCollectionLayout = gameCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        gameCollectionLayout.itemSize = CGSize(width: size, height: size + 140)
        let iOSCollectionLayout = iOSCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        iOSCollectionLayout.itemSize = CGSize(width: size, height: size + 140)
        let androidCollectionLayout = androidCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        androidCollectionLayout.itemSize = CGSize(width: size, height: size + 140)
        let webCollectionLayout = webCollectionView.collectionViewLayout as! UICollectionViewFlowLayout
        webCollectionLayout.itemSize = CGSize(width: size, height: size + 140)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func callAPI(completion: @escaping () -> Void) {
        let api = "https://fathomless-harbor-32460.herokuapp.com/api/v1/courses?auth_token=\(Auth.token!)"
        let url = URL(string: api)
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            } else {
                if let content = data {
                    do {
                        if let json = try JSONSerialization.jsonObject(with: content, options: JSONSerialization.ReadingOptions.mutableContainers) as? Dictionary<String, AnyObject> {
                            if let jsonArray = json["result"] as? NSArray {
                                
                                self.enlightenmentArray.removeAll()
                                self.gameArray.removeAll()
                                self.iOSArray.removeAll()
                                self.androidArray.removeAll()
                                self.webArray.removeAll()
                                
                                for i in 0..<jsonArray.count {
                                    if let item = jsonArray[i] as? Dictionary<String, AnyObject> {
                                        let lessonData = Lessondata(id: item["id"] as! Int, title: item["title"] as! String, start_date: item["start_date"] as! String, due_date: item["due_date"] as! String, course_date: item["course_date"] as! String, course_id: item["course_id"] as! String, course_people: item["course_people"] as! String, quota: item["quota"] as! String, course_cost: item["course_cost"] as! String, content: item["content"] as! String, image: item["image"] as! Dictionary<String, AnyObject>, category: item["category"] as! [Dictionary<String, AnyObject>])
                                        let category = lessonData.category[0]
                                        switch category["classification"] as! String {
                                        case "程式啟蒙":
                                            self.enlightenmentArray.append(lessonData)
                                        case "遊戲程式":
                                            self.gameArray.append(lessonData)
                                        case "IOS程式":
                                            self.iOSArray.append(lessonData)
                                        case "Android程式":
                                            self.androidArray.append(lessonData)
                                        case "網頁程式":
                                            self.webArray.append(lessonData)
                                        default:
                                            break
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
    
    func getApi() {
        SVProgressHUD.show(withStatus: "讀取中")
        callAPI {
            DispatchQueue.main.async {
                self.enlightenmentCollectionView.reloadData()
                self.gameCollectionView.reloadData()
                self.iOSCollectionView.reloadData()
                self.androidCollectionView.reloadData()
                self.webCollectionView.reloadData()
                SVProgressHUD.dismiss()
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.width * 0.6 + 160
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
    
}

extension LessonTableViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView.restorationIdentifier! {
        case "Enlightenment":
            return enlightenmentArray.count
        case "Game":
            return gameArray.count
        case "iOS":
            return iOSArray.count
        case "Android":
            return androidArray.count
        case "Web":
            return webArray.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MainCollectionViewCell
//        let maindata = mm.getArray(id: collectionView.restorationIdentifier!)[indexPath.row]
        var lessonData: Lessondata!
        switch collectionView.restorationIdentifier! {
        case "Enlightenment":
            lessonData = enlightenmentArray[indexPath.row]
        case "Game":
            lessonData = gameArray[indexPath.row]
        case "iOS":
            lessonData = iOSArray[indexPath.row]
        case "Android":
            lessonData = androidArray[indexPath.row]
        case "Web":
            lessonData = webArray[indexPath.row]
        default:
            break
        }
        
        let url = lessonData.image["medium"] as! Dictionary<String, String>
        mm.getImage(urlString: url["url"]!) { (image) in
            DispatchQueue.main.async {
                cell.logoImageView.image = image
            }
        }
        
        cell.titleLabel.text = lessonData.title
        cell.backgroundColor = UIColor.clear
        
        cell.teacherImageView.layer.cornerRadius = 25
        cell.teacherImageView.contentMode = .scaleAspectFit
        
        if collectionView.restorationIdentifier == "nil" {
            cell.weekLabel.text = "數分鐘前"
            cell.likeLabel.text = "0"
            cell.commentLabel.text = "0"
        } else {
            let week = ["一週前", "二週前", "三週前"]
            let random = Int(arc4random_uniform(3))
            cell.weekLabel.text = week[random]
            
            cell.likeLabel.text = "\(arc4random_uniform(40) + 1)"
            cell.commentLabel.text = "\(arc4random_uniform(40) + 1)"
        }
        
        return cell
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        //        let maindata = mm.getArrat(id: collectionView.restorationIdentifier!)[indexPath.row]
//        //        NotificationCenter.default.post(name: Notification.Name("selected"), object: nil, userInfo: ["maindata" : maindata])
//        let id = collectionView.restorationIdentifier!
//        let row = indexPath.row
//        NotificationCenter.default.post(name: Notification.Name("selected"), object: nil, userInfo: ["id" : id, "row" : row])
//    }

}

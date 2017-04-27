//
//  MainData.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class Maindata {
    var title = ""
    var start_date = ""
    var due_date = ""
    var organiser = ""
    var phone = ""
    var email = ""
    var image: Dictionary<String, AnyObject> = [:]
    var category: [Dictionary<String, AnyObject>] = []
    var contestant: [Dictionary<String, AnyObject>] = []
    
    init(title:String, start_date:String,due_date:String, organiser: String, phone: String, email: String, image: Dictionary<String, AnyObject>, category: [Dictionary<String, AnyObject>], contestant: [Dictionary<String, AnyObject>]) {
        self.title = title
        self.start_date = start_date
        self.due_date = due_date
        self.organiser = organiser
        self.phone = phone
        self.email = email
        self.image = image
        self.category = category
        self.contestant = contestant
    }
}

class MaindataManager {
    private static var maindataInstance: MaindataManager?
    static func shareInstance() -> MaindataManager {
        if maindataInstance == nil {
            maindataInstance = MaindataManager()
        }
        return maindataInstance!
    }
    
    private var maindata: Maindata
    private var enlightenmentArray: [Maindata] = []
    private var gameArray: [Maindata] = []
    private var iOSArray: [Maindata] = []
    private var androidArray: [Maindata] = []
    private var webArray: [Maindata] = []
    private var imageDict: Dictionary<String, UIImage> = [:]
    
    private init() {
        maindata = Maindata.init(title: "", start_date: "", due_date: "", organiser: "", phone: "", email: "", image: [:], category: [], contestant: [])
        enlightenmentArray = []
        gameArray = []
        iOSArray = []
        androidArray = []
        webArray = []
    }
    
    func callAPI(completion: @escaping () -> Void) {
        let api = "https://fathomless-harbor-32460.herokuapp.com/api/v1/games"
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
                                        let maindata = Maindata(title: item["title"] as! String, start_date: item["start_date"] as! String, due_date: item["due_date"] as! String, organiser: item["organiser"] as! String, phone: item["phone"] as! String, email: item["email"] as! String, image: item["image"] as! Dictionary<String, AnyObject>, category: item["category"] as! [Dictionary<String, AnyObject>], contestant: item["Contestant"] as! [Dictionary<String, AnyObject>])
                                        let category = maindata.category[0]
                                        switch category["category"] as! String {
                                        case "程式啟蒙":
                                            self.enlightenmentArray.append(maindata)
                                        case "遊戲程式":
                                            self.gameArray.append(maindata)
                                        case "IOS程式":
                                            self.iOSArray.append(maindata)
                                        case "Android程式":
                                            self.androidArray.append(maindata)
                                        case "網頁程式":
                                            self.webArray.append(maindata)
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
    
    func getCount(id: String) -> Int {
        switch id {
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
    
    func getArrat(id: String) -> [Maindata] {
        switch id {
        case "Enlightenment":
            return enlightenmentArray
        case "Game":
            return gameArray
        case "iOS":
            return iOSArray
        case "Android":
            return androidArray
        case "Web":
            return webArray
        default:
            return []
        }
    }
    
    func getImage(urlString: String, completion: @escaping (_ image: UIImage) -> Void) {
        if let image = imageDict[urlString] {
            completion(image)
        } else {
            if let url = URL(string: urlString) {
                let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url, completionHandler: { (data, response, error) in
                    completion(UIImage(data: data!)!)
                })
                task.resume()
            }
        }
        
    }
}

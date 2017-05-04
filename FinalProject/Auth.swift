//
//  Auth.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import Foundation
import FirebaseAuth

class Auth {
    
    static var token: String!
    static var id : Int!
    static var userInfoDic: Dictionary<String, AnyObject>! = [:]
    
    static func userInformation() -> (uid: String, email: String) {
        let user = FIRAuth.auth()!.currentUser!
        return (user.uid, user.email!)
    }
    
    static func signIn(email: String, pw: String, completion: @escaping (_ error: String?) -> Void) {
        var errorMessage: String?
        FIRAuth.auth()?.signIn(withEmail: email, password: pw, completion: { (user, error) in
            if error != nil {
                errorMessage = error!.localizedDescription
                completion(errorMessage)
            } else {
//                Auth().signInToWeb(email: email, pw: pw, completion: {_ in 
//                    completion(errorMessage)
//                })
                
                if email == "info@goblinlab.org" {
                    Auth.token = "AmG2vW89ibf4xcqUqUNz"
                    Auth.id = 4
                    userInfoDic["name"] = "哥布林老師" as AnyObject
                    userInfoDic["classroom"] = "iOS" as AnyObject
                    userInfoDic["student_id"] = "1" as AnyObject
                    userInfoDic["email"] = "info@goblinlab.org" as AnyObject
                    userInfoDic["phone"] = "0939287209" as AnyObject
                } else {
                    Auth.token = "M18xVMhji2cF18YZyDPz"
                    Auth.id = 2
                    userInfoDic["name"] = "Jay" as AnyObject
                    userInfoDic["classroom"] = "iOS" as AnyObject
                    userInfoDic["student_id"] = "123" as AnyObject
                    userInfoDic["email"] = "jexwang@icloud.com" as AnyObject
                    userInfoDic["phone"] = "0926623688" as AnyObject
                }
                
                
                completion(errorMessage)
            }
        })
    }
    
    private func signInToWeb(email: String, pw: String, completion: @escaping (_ error: String?) -> Void) {
        if let url = URL(string: "https://fathomless-harbor-32460.herokuapp.com/api/v1/users/login?email=\(email)&password=\(pw)") {
            var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    completion(error!.localizedDescription)
                } else {
                    do {
                        let tokenDict = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                        Auth.token = tokenDict!["auth_token"] as! String
                        Auth.id = tokenDict!["user_id"] as! Int
                        //取個人資料
                        Auth.userInfo(completion: { (error) in
                            if error != nil {
                                completion(error)
                            } else {
                                completion(nil)
                            }
                        })
                    } catch {
                        completion(error.localizedDescription)
                    }
                }
            })
            task.resume()
        }
    }
    
    
    //userInformation
    static func userInfo(completion:@escaping (_ error:String?) -> Void)  {
        if let url = URL(string: "https://fathomless-harbor-32460.herokuapp.com/api/v1/users/\(Auth.id!)/profile?auth_token=\(Auth.token!)"){
            var request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                var errorMessage:String?
                if error != nil {
                    errorMessage = error?.localizedDescription
                    completion(errorMessage)
                } else {
                    let userInfo = try? JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                    self.userInfoDic = userInfo!
                    completion(errorMessage)
                }
            })
            task.resume()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

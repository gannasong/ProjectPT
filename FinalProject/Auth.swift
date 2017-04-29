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
    
    static func userInformation() -> (uid: String, email: String) {
        let user = FIRAuth.auth()!.currentUser!
        return (user.uid, user.email!)
    }
    
    static func signIn(email: String, pw: String, completion: @escaping (_ error: String?) -> Void) {
        var errorMessage: String?
        FIRAuth.auth()?.signIn(withEmail: email, password: pw, completion: { (user, error) in
            if error != nil {
                errorMessage = error!.localizedDescription
            } else {
                Auth().signInToWeb(email: email, pw: pw, completion: {
                    completion(errorMessage)
                })
            }
        })
    }
    
    private func signInToWeb(email: String, pw: String, completion: @escaping () -> Void) {
        if let url = URL(string: "https://fathomless-harbor-32460.herokuapp.com/api/v1/users/login?email=\(email)&password=\(pw)") {
            var request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
            request.httpMethod = "POST"
            let task = URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    print(error!.localizedDescription)
                } else {
                    do {
                        let tokenDict = try JSONSerialization.jsonObject(with: data!, options: []) as? Dictionary<String, AnyObject>
                        Auth.token = tokenDict!["auth_token"] as! String
//                        print("TOKEN: \(Auth.token!)")
                        completion()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            })
            task.resume()
        }
    }
}

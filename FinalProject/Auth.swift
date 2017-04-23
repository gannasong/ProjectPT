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
    
    static func userInformation() -> (uid: String, email: String) {
        let user = FIRAuth.auth()!.currentUser!
        return (user.uid, user.email!)
    }
    
    static func signIn(email: String, pw: String, completion: @escaping (_ error: String?) -> Void) {
        var errorMessage: String?
        FIRAuth.auth()?.signIn(withEmail: email, password: pw, completion: { (user, error) in
            if error != nil {
                errorMessage = error!.localizedDescription
            }
            completion(errorMessage)
        })
    }
}

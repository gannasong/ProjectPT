//
//  ViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit
import SVProgressHUD

class LoginController: UIViewController {
    
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        createGradientLayer()
        
        if let email = UserDefaults.standard.string(forKey: "email") {
            emailTextField.text = email
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createGradientLayer() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [UIColor.init(ciColor: CIColor(red: 9/255, green: 101/255, blue: 190/255, alpha: 0.8)).cgColor, UIColor.init(ciColor: CIColor(red: 131/255, green: 221/255, blue: 93/255, alpha: 0.8)).cgColor]
        self.bgImageView.layer.addSublayer(gradientLayer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func loginButton(_ sender: UIButton) {
        guard emailTextField.text != "" && pwTextField.text != "" else {
            present(Library.alert(message: "請輸入信箱及密碼", needButton: true), animated: true, completion: nil)
            return
        }
        
        SVProgressHUD.show(withStatus: "登入中")
        Auth.signIn(email: emailTextField.text!, pw: pwTextField.text!) { (error) in
            if error != nil {
                SVProgressHUD.dismiss()
                self.present(Library.alert(message: error!, needButton: true), animated: true, completion: nil)
            } else {
                UserDefaults.standard.set(self.emailTextField.text!, forKey: "email")
                SVProgressHUD.showSuccess(withStatus: "登入成功")
                self.performSegue(withIdentifier: "Login", sender: self)
            }
        }
    }

}


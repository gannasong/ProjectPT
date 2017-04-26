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
    
//    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var pwTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        createGradientLayer()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func createGradientLayer() {
//        gradientLayer = CAGradientLayer()
//        gradientLayer.frame = self.view.bounds
//        gradientLayer.colors = [UIColor.red.cgColor, UIColor.yellow.cgColor]
//        gradientLayer.borderColor = UIColor
//        
//        self.view.layer.addSublayer(gradientLayer)
//    }

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
                SVProgressHUD.showSuccess(withStatus: "登入成功")
                SVProgressHUD.dismiss(withDelay: 1)
                self.performSegue(withIdentifier: "Login", sender: self)
            }
        }
    }

}


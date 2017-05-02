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
    @IBOutlet weak var emailImageView: UIImageView!
    @IBOutlet weak var pwImageView: UIImageView!
    @IBOutlet weak var loginSlider: UISlider!
    @IBOutlet weak var loginImageView: UIImageView!
    
    let emailTextField = UITextField()
    let pwTextField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.frame.size = CGSize(width: emailImageView.frame.width * 0.8, height: emailImageView.frame.height * 0.8)
        emailTextField.center = emailImageView.center
        emailTextField.placeholder = "username"
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.textColor = UIColor(red: 157.0/255.0, green: 201.0/255.0, blue: 0, alpha: 1)
        emailTextField.keyboardType = .emailAddress
        emailImageView.addSubview(emailTextField)
        
        pwTextField.frame.size = CGSize(width: pwImageView.frame.width * 0.8, height: pwImageView.frame.height * 0.8)
        pwTextField.center = emailImageView.center
        pwTextField.placeholder = "username"
        pwTextField.font = UIFont.systemFont(ofSize: 16)
        pwTextField.textColor = UIColor(red: 157.0/255.0, green: 201.0/255.0, blue: 0, alpha: 1)
        pwTextField.isSecureTextEntry = true
        pwTextField.text = "P@ssw0rd"
        pwImageView.addSubview(pwTextField)
        
        loginSlider.setThumbImage(UIImage(named: "loginBtn"), for: .normal)
        loginSlider.frame.size.width = view.frame.width * 0.8
        loginSlider.frame.origin = CGPoint(x: 0, y: 10)
        loginImageView.addSubview(loginSlider)
        
        if let email = UserDefaults.standard.string(forKey: "email") {
            emailTextField.text = email
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        loginSlider.value = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @IBAction func loginSliderAction(_ sender: UISlider) {
        if sender.value != 1 {
            sender.value = 0
        } else {
            guard emailTextField.text != "" && pwTextField.text != "" else {
                let alert = Library.alert(message: "請輸入信箱及密碼", needButton: false)
                let alertAction = UIAlertAction(title: "確定", style: .cancel, handler: { _ in
                    sender.value = 0
                })
                alert.addAction(alertAction)
                present(alert, animated: true, completion: nil)
                return
            }
            SVProgressHUD.show(withStatus: "登入中")
            Auth.signIn(email: emailTextField.text!, pw: pwTextField.text!) { (error) in
                if error != nil {
                    SVProgressHUD.dismiss()
                    let alert = Library.alert(message: error!, needButton: false)
                    let alertAction = UIAlertAction(title: "確定", style: .cancel, handler: { _ in
                        sender.value = 0
                    })
                    alert.addAction(alertAction)
                    self.present(alert, animated: true, completion: nil)
                } else {
                    UserDefaults.standard.set(self.emailTextField.text!, forKey: "email")
                    SVProgressHUD.showSuccess(withStatus: "登入成功")
                    self.performSegue(withIdentifier: "Login", sender: self)
                }
            }
        }
    }

}


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
        if let getEmail = UserDefaults.standard.string(forKey: "email") {
            checkReUser = true
            rememberButton.setImage(UIImage(named: "check02"), for: .normal)
            emailTextField.text = getEmail
        } else {
            checkReUser = false
            rememberButton.setImage(UIImage(named: "check01"), for: .normal)
        }
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
        emailTextField.frame.size = CGSize(width: emailImageView.frame.width, height: emailImageView.frame.height * 0.8)
        emailTextField.frame.origin = CGPoint(x: 20, y: 5)
        emailTextField.placeholder = "username"
        emailTextField.font = UIFont.systemFont(ofSize: 16)
        emailTextField.textColor = UIColor(red: 140.0/255.0, green: 180.0/255.0, blue: 1/255.0, alpha: 1)
        emailTextField.keyboardType = .emailAddress
        
        emailTextField.clearButtonMode = .whileEditing
        emailImageView.addSubview(emailTextField)
        
        pwTextField.frame.size = CGSize(width: pwImageView.frame.width, height: pwImageView.frame.height * 0.8)
        pwTextField.frame.origin = CGPoint(x: 20, y: 5)
        pwTextField.placeholder = "username"
        pwTextField.font = UIFont.systemFont(ofSize: 16)
        pwTextField.textColor = UIColor(red: 140.0/255.0, green: 180.0/255.0, blue: 1/255.0, alpha: 1)
        pwTextField.isSecureTextEntry = true
        pwTextField.text = "P@ssw0rd"
        
        pwTextField.clearButtonMode = .whileEditing
        
        pwImageView.addSubview(pwTextField)
        
        loginSlider.setThumbImage(UIImage(named: "loginBtn"), for: .normal)
        loginSlider.frame.size.width = view.frame.width * 0.8
        loginSlider.frame.origin = CGPoint(x: 0, y: 10)
        loginImageView.addSubview(loginSlider)
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
                    if self.checkReUser {
                        UserDefaults.standard.set(self.emailTextField.text!, forKey: "email")
                    } else {
                        UserDefaults.standard.set(nil, forKey: "email")
                    }
                    
                    SVProgressHUD.showSuccess(withStatus: "登入成功")
                    self.performSegue(withIdentifier: "Login", sender: self)
                }
            }
        }
    }

    var checkReUser:Bool!
    @IBOutlet weak var rememberButton: UIButton!
    
    @IBAction func rememberButton(_ sender: UIButton) {
        if checkReUser {
            sender.setImage(UIImage(named: "check01"), for: .normal)
        } else {
            sender.setImage(UIImage(named: "check02"), for: .normal)
        }
        checkReUser = !checkReUser
    }
    
    
    
    
    
}


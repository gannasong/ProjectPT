//
//  UserInfoTableViewController.swift
//  FinalProject
//
//  Created by SUNG HAO LIN on 2017/4/26.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class UserInfoTableViewController: UITableViewController,UINavigationControllerDelegate,UIImagePickerControllerDelegate {

    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    let mm = MaindataManager.shareInstance()
    
    
    func infoLabel(sender:Bool) {
        nameLabel.isHidden = sender
        classLabel.isHidden = sender
        numberLabel.isHidden = sender
        emailLabel.isHidden = sender
        phoneLabel.isHidden = sender
    }

    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        nameLabel.text = Auth.userInfoDic["name"] as? String
        classLabel.text = Auth.userInfoDic["classroom"] as? String
        numberLabel.text = Auth.userInfoDic["student_id"] as? String
        emailLabel.text = Auth.userInfoDic["email"] as? String
        phoneLabel.text = Auth.userInfoDic["phone"] as? String
        
//        if let tryImage = Auth.userInfoDic["file_location"]!["medium"] as? Dictionary<String,String> {
//            if let getImageUrlString = tryImage["url"] {
//                mm.getImage(urlString: getImageUrlString, completion: { (image) in
//                    self.userImageView.image = image
//                    self.userImageView.contentMode = .scaleAspectFill
//                    self.userImageView.clipsToBounds = true
//                    
//                })
//            }
//        }
        
        
    }
    
    //返回主頁
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
//    //修改個人資料
//    @IBAction func editUserInfo(_ sender: UIButton) {
//        if sender.title(for: .normal) == "編輯個人資料" {
//            nameField.text = nameLabel.text
//            classField.text = classLabel.text
//            numberField.text = numberLabel.text
//            emailField.text = emailLabel.text
//            phoneField.text = phoneLabel.text
//            infoLabel(sender: true)
//            infoField(sender: false)
//            sender.setTitle("確定修改資料", for: .normal)
//        } else {
//            nameLabel.text = nameField.text
//            classLabel.text = classField.text
//            numberLabel.text = numberField.text
//            emailLabel.text = emailField.text
//            phoneLabel.text = phoneField.text
//            infoLabel(sender: false)
//            infoField(sender: true)
//            sender.setTitle("編輯個人資料", for: .normal)
//        }
//
//    }
    
    
    //選照片
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let imagePicker = UIImagePickerController()
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = true
            imagePicker.delegate = self
            present(imagePicker, animated: true, completion: nil)
            
        }
    }
    
    //選完照片之後的動作
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
            userImageView.image = image
            userImageView.layer.cornerRadius = userImageView.frame.width / 2
            userImageView.contentMode = .scaleAspectFill
            userImageView.clipsToBounds = true
            dismiss(animated:true, completion: nil)
        }
        
    }

    
    
    
    
    
    
    
    
    
    
    //
}

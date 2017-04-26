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
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var classField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    func infoField(sender:Bool) {
        nameField.isHidden = sender
        classField.isHidden = sender
        numberField.isHidden = sender
        emailField.isHidden = sender
        phoneField.isHidden = sender
    }
    
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
        infoField(sender: true)
    }
    
    //返回主頁
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //修改個人資料
    @IBAction func editUserInfo(_ sender: UIButton) {
        if sender.title(for: .normal) == "編輯個人資料" {
            nameField.text = nameLabel.text
            classField.text = classLabel.text
            numberField.text = numberLabel.text
            emailField.text = emailLabel.text
            phoneField.text = phoneLabel.text
            infoLabel(sender: true)
            infoField(sender: false)
            sender.setTitle("確定修改資料", for: .normal)
        } else {
            nameLabel.text = nameField.text
            classLabel.text = classField.text
            numberLabel.text = numberField.text
            emailLabel.text = emailField.text
            phoneLabel.text = phoneField.text
            infoLabel(sender: false)
            infoField(sender: true)
            sender.setTitle("編輯個人資料", for: .normal)
        }

    }
    
    
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

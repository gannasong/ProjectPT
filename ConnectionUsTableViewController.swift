//
//  ConnectionUsTableViewController.swift
//  FinalProject
//
//  Created by SUNG HAO LIN on 2017/4/26.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit
import MessageUI
class ConnectionUsTableViewController: UITableViewController, MFMailComposeViewControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    //返回主頁
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    //發送email
    @IBAction func connectionEmail(_ sender: UIButton) {
        let mailCompese = MFMailComposeViewController()
        mailCompese.mailComposeDelegate = self
        mailCompese.setToRecipients(["info@goblinlab.org"])
        mailCompese.setSubject("哥布林程式教育學苑使用者反饋")
        mailCompese.setMessageBody("謝謝你寶貴的意見，我們會盡快與你聯絡。", isHTML: false)
        
        if MFMailComposeViewController.canSendMail() {
            present(mailCompese, animated: true, completion: nil)
        } else {
            print("something wrong")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    
    //官方電話
    @IBAction func connectionPhone(_ sender: UIButton) {
        let url:NSURL = URL(string: "TEL:0282752408")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    //專員手機
    @IBAction func connectionMobile(_ sender: UIButton) {
        let url:NSURL = URL(string: "TEL:0939287209")! as NSURL
        UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
    }
    
    
    
    
    
    
    
    //
}

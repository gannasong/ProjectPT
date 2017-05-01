//
//  OnlineGMViewController.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/30.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit
import SVProgressHUD
import JSQMessagesViewController
import FirebaseDatabase

class OnlineGmViewController: JSQMessagesViewController {
    
    let ref = FIRDatabase.database().reference()
    var messageArray: [Dictionary<String, AnyObject>] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        collectionView?.collectionViewLayout.incomingAvatarViewSize = .zero
        collectionView?.collectionViewLayout.outgoingAvatarViewSize = .zero
        
        SVProgressHUD.show(withStatus: "連線中")
        ref.child("onlineGm").observe(.childAdded, with: { (snapShots) in
            if let message = snapShots.value as? Dictionary<String, AnyObject> {
                self.messageArray.append(message)
                self.finishReceivingMessage(animated: true)
                SVProgressHUD.dismiss()
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        ref.child("onlineGm").removeAllObservers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func senderId() -> String {
        return Auth.token
    }
    
    override func senderDisplayName() -> String {
        return Auth.token
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageDataForItemAt indexPath: IndexPath) -> JSQMessageData {
        let message = messageArray[indexPath.row]
        guard let senderID = message["senderId"] as? String, let senderDisplayName = message["senderDisplayName"] as? String, let date = message["date"] as? TimeInterval, let text = message["text"] as? String else {
            return JSQMessage(senderId: "", displayName: "", text: "")
        }
        let dateToNow = Date(timeIntervalSince1970: date)
        return JSQMessage(senderId: senderID, senderDisplayName: senderDisplayName, date: dateToNow, text: text)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, messageBubbleImageDataForItemAt indexPath: IndexPath) -> JSQMessageBubbleImageDataSource? {
        let message = messageArray[indexPath.row]
        let factory = JSQMessagesBubbleImageFactory()
        if message["senderId"] as! String == Auth.token {
            return factory.outgoingMessagesBubbleImage(with: #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1))
        } else {
            return factory.incomingMessagesBubbleImage(with: #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1))
        }
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, attributedTextForMessageBubbleTopLabelAt indexPath: IndexPath) -> NSAttributedString {
        let message = messageArray[indexPath.row]
        let name = message["senderDisplayName"] as! String
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        let date = dateFormatter.string(from: Date(timeIntervalSince1970: message["date"] as! TimeInterval))
        
        let bubbleTopLabelString = "\(name) - \(date)"
        return NSAttributedString(string: bubbleTopLabelString)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout, heightForMessageBubbleTopLabelAt indexPath: IndexPath) -> CGFloat {
        return 15
    }
    
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        let randomId = ref.child("onlineGm").childByAutoId()
        randomId.setValue(["text" : text, "senderId" : senderId, "senderDisplayName" : senderDisplayName, "date" : date.timeIntervalSince1970]) { (error, ref) in
            if error != nil {
                self.present(Library.alert(message: error!.localizedDescription, needButton: true), animated: true, completion: nil)
            } else {
                self.finishSendingMessage(animated: true)
            }
        }
    }
    
    @IBAction func backButton(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

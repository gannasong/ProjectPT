//
//  MainCollectionViewCell.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/4/23.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var teacherImageView: UIImageView!
    @IBOutlet weak var weekLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    
    
    @IBAction func likeButton(_ sender: UIButton) {
        if sender.imageView?.image == UIImage(named: "untrack") {
            let currentLike = Int(likeLabel.text!)
            likeLabel.text = "\(currentLike! + 1)"
            sender.setImage(UIImage(named: "tracking"), for: .normal)
        } else {
            let currentLike = Int(likeLabel.text!)
            likeLabel.text = "\(currentLike! - 1)"
            sender.setImage(UIImage(named: "untrack"), for: .normal)
        }
    }
    
}

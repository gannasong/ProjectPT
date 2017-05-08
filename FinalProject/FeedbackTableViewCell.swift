//
//  FeedbackTableViewCell.swift
//  FinalProject
//
//  Created by 王冠綸 on 2017/5/7.
//  Copyright © 2017年 jexwang. All rights reserved.
//

import UIKit

class FeedbackTableViewCell: UITableViewCell {
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet var feedbackImages: [UIImageView]!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        for x in 1...15 {
            let imageView = viewWithTag(x) as! UIImageView
            imageView.image = nil
        }
        
//        for y in 6...10 {
//            let imageView = viewWithTag(y) as! UIImageView
//            imageView.image = UIImage(named: "favorite_on")
//        }
//        
//        for z in 11...15 {
//            let imageView = viewWithTag(z) as! UIImageView
//            imageView.image = UIImage(named: "most_viewed_on")
//        }
    }

}

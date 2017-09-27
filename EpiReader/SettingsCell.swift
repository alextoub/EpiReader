//
//  SettingsCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 26/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class AboutOptCell: UITableViewCell {

    @IBOutlet weak var aboutOptLabel: UILabel!
    @IBOutlet weak var aboutOptImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        aboutOptImageView.layer.masksToBounds = true
        aboutOptImageView.layer.cornerRadius = aboutOptImageView.bounds.height / 2
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
//
//class NotificationOptCell: UITableViewCell {
//
//    @IBOutlet weak var notificationOptLabel: UILabel!
//    @IBOutlet weak var notificationOptImageView: UIImageView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        notificationOptImageView.layer.masksToBounds = true
//        notificationOptImageView.layer.cornerRadius = notificationOptImageView.bounds.height / 2
//    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//}
//
//class TagOptCell: UITableViewCell {
//
//    @IBOutlet weak var tagOptLabel: UILabel!
//    @IBOutlet weak var tagOptImageView: UIImageView!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//
//        tagOptImageView.layer.masksToBounds = true
//        tagOptImageView.layer.cornerRadius = tagOptImageView.bounds.height / 2
//    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }
//}


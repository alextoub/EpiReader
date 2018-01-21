//
//  SettingCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 28/10/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class SettingCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var infoSwitch: UISwitch!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconView: UIView!
    @IBOutlet weak var iconImageView: UIImageView!
    
    func configure(title: String, color: UIColor, image: UIImage) {
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = iconView.bounds.height / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.bounds.height / 2
        
        iconImageView.image = image
        iconView.backgroundColor = color
        titleLabel.text = title
        
        if (infoSwitch != nil) {
        infoSwitch.isOn = UserDefaults.standard.bool(forKey: "CNEnabled") //StaticData.isCNEnabled
        }
        
    }
    
    @IBAction func infoSwitchAction(_ sender: Any) {
        if (sender as! UISwitch).isOn {
            UserDefaults.standard.set(true, forKey: "CNEnabled")
        }
        else {
            UserDefaults.standard.set(false, forKey: "CNEnabled")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

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
    @IBOutlet weak var cellView: CustomView!
    
    var setting: Setting?
    
    func themeConfigure() {
        titleLabel.textColor = StaticData.theme.titleColor
        cellView.backgroundColor = StaticData.theme.backGroundCell
        self.backgroundColor = StaticData.theme.backgroundColor
    }
    
    func configure(setting: Setting) {
        configure()
        
        iconImageView.image = setting.image
        iconView.backgroundColor = setting.color
        titleLabel.text = setting.title
        
        infoSwitch.isHidden = !setting.isSwitchable
        
        if (setting.isSwitchable) {
            infoSwitch.isOn = UserDefaults.standard.bool(forKey: setting.key)
        }
        self.setting = setting
    }
    
    func configure() {
        iconView.layer.masksToBounds = true
        iconView.layer.cornerRadius = iconView.bounds.height / 2
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.cornerRadius = iconImageView.bounds.height / 2
    }
    
    @IBAction func infoSwitchAction(_ sender: Any) {
        
        UserDefaults.standard.set((sender as! UISwitch).isOn, forKey: (setting?.key)!)
        
        if setting?.key == "isDarkMode" {
            Theme.loadTheme()
        }
        
//        
//        if (sender as! UISwitch).isOn {
//            UserDefaults.standard.set(true, forKey: (setting?.key)!)
//        }
//        else {
//            UserDefaults.standard.set(false, forKey: (setting?.key)!)
//        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        themeConfigure()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

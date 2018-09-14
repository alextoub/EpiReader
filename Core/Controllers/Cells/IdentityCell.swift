//
//  IdentityCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 27/10/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class IdentityCell: UITableViewCell {

    @IBOutlet weak var logoButton: UIButton!
    @IBOutlet weak var logoAppImageView: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    func configureTheme() {
        containerView.backgroundColor = StaticData.theme.backGroundCell
        authorLabel.textColor = StaticData.theme.titleColor
        appNameLabel.textColor = StaticData.theme.titleColor
        versionLabel.textColor = StaticData.theme.subtitleColor
    }
    
    func configure() {
        logoAppImageView.image = #imageLiteral(resourceName: "logo_app")
        versionLabel.text = appVersionValue()
        configureTheme()
    }
    
    @IBAction func logoButtonAction(_ sender: Any) {
        let url : URL = URL(string: "http://www.epimac.org/")!
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
    
    @IBAction func envelopeButtonAction(_ sender: Any) {
        let email = "alex.toubiana@epimac.org"
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

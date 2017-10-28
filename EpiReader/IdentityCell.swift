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
    @IBOutlet weak var mailButton: UIButton!
    
    func configure() {
        logoAppImageView.layer.masksToBounds = true
        logoAppImageView.layer.cornerRadius = logoAppImageView.bounds.height / 2
        logoAppImageView.image = #imageLiteral(resourceName: "logo_app")
        
        versionLabel.text = appVersionValue()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

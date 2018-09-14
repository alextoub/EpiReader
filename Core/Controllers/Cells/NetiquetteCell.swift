//
//  NetiquetteCell.swift
//  EpiReader
//
//  Created by Alex Toubiana on 9/24/17.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class NetiquetteCell: UITableViewCell {

    @IBOutlet weak var newsView: CustomView!
    @IBOutlet weak var contentTextView: UITextView!
    @IBOutlet weak var containerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureTheme() {
        newsView.backgroundColor = StaticData.theme.backGroundCell
        contentTextView.textColor = StaticData.theme.titleColor
        containerView.backgroundColor = StaticData.theme.backgroundColor
    }
}

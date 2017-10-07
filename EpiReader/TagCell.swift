//
//  TagCell.swift
//  EpiReader
//
//  Created by Alex Toubiana on 9/25/17.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class TagCell: UITableViewCell {

    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func configure(_ tag: Tag) {
        colorView.layer.masksToBounds = true
        colorView.layer.cornerRadius = colorView.bounds.height / 2
        
        colorView.backgroundColor = tag.attributedColor
        nameLabel.text = tag.tagName

    }
}

//
//  AddGroupCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class AddGroupCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var isFavoriteButton: UIButton!
    @IBOutlet weak var inactiveView: UIView!
    
    // MARK: - Cell delegates
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ group: Group, favGroup: [String], row: Int) {
        groupNameLabel.text = group.group_name
        if favGroup.contains(group.group_name!) {
            isFavoriteButton.isSelected = true
            isFavoriteButton.setImage(#imageLiteral(resourceName: "switch_on"), for: .selected)
        }
        else {
            isFavoriteButton.isSelected = false
            isFavoriteButton.setImage(#imageLiteral(resourceName: "switch_off"), for: .normal)
        }
        inactiveView.isHidden = group.available ?? false
    }
}

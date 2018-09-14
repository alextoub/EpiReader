//
//  GroupCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var groupNameLabel: UILabel!
    @IBOutlet weak var groupView: UIView!
    @IBOutlet weak var nbNewsLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    // MARK: - Cell delegates
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(favorite: Favorite) {
        groupNameLabel.text = favorite.group_name
        nbNewsLabel.text = String(describing: favorite.topic_nb ?? 0)
        
        groupView.layer.masksToBounds = true
        groupView.layer.cornerRadius = groupView.bounds.height / 2
        
        configureTheme()
    }
    
    func configureTheme() {
        containerView.backgroundColor = StaticData.theme.backGroundCell
        groupNameLabel.textColor = StaticData.theme.titleColor
    }
}

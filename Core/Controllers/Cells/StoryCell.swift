//
//  StoryCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 30/10/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {
    
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

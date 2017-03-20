//
//  GroupCell.swift
//  EpiNotifier
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class GroupCell: UITableViewCell {
  
  @IBOutlet weak var groupNameLabel: UILabel!
  @IBOutlet weak var groupView: UIView!
  @IBOutlet weak var nbNewsLabel: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}

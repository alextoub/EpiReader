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
  
  // MARK: - Cell delegates
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}

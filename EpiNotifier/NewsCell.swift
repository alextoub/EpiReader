//
//  NewsCell.swift
//  EpiNotifier
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
  
  @IBOutlet weak var readIndicator: UIView!
  @IBOutlet weak var authorLabel: UILabel!
  @IBOutlet weak var subjectLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var msgNbIndicator: UIImageView!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
  }
  
}

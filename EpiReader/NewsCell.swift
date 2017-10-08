//
//  NewsCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var readIndicator: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var msgNbIndicator: UIImageView!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var contentCellView: CustomView!
    
    // MARK: - Cell delegates
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ news: News) {
        let authorArr = parseAuthor(news.author!)
        authorLabel.text = authorArr[0]
        mailLabel.text = authorArr[1]
//        readIndicator.layer.masksToBounds = true
//        readIndicator.layer.cornerRadius = readIndicator.bounds.height / 2
        dateLabel.text = StrToAbrev(dateStr: news.creation_date!)
        
        if news.msg_nb! > 1 {
            msgNbIndicator.image = #imageLiteral(resourceName: "double_arrow_green")
        }
        else {
            msgNbIndicator.image = #imageLiteral(resourceName: "single_arrow")
        }
        
        if news.isRead != nil && news.isRead! {
            readIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            if msgNbIndicator.image == #imageLiteral(resourceName: "double_arrow_green"){
                msgNbIndicator.image = #imageLiteral(resourceName: "double_arrow_grey")
            }
        }
        else {
            readIndicator.backgroundColor = #colorLiteral(red: 0.3430494666, green: 0.8636034131, blue: 0.467017293, alpha: 1)
        }        
    }
    
}

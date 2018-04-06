//
//  NewsCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class NewsCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // MARK: - Outlets
    
    @IBOutlet weak var readIndicator: UIView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var msgNbIndicator: UIImageView!
    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var contentCellView: CustomView!
    
    @IBOutlet weak var msgNbView: UIView!
    @IBOutlet weak var msgNbLabel: UILabel!
        
    @IBOutlet weak var tagCollectionView: UICollectionView!
    
    var tags = [Tag]()
    
    // MARK: - Cell delegates
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tagCollectionView.dataSource = self
        tagCollectionView.delegate = self
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(_ news: News) {
        let authorArr = parseAuthor(news.author!)
        authorLabel.text = authorArr[0]
        mailLabel.text = authorArr[1]
        dateLabel.text = StrToInfo(dateStr: news.creation_date!)
        
        msgNbView.backgroundColor = #colorLiteral(red: 0.4119389951, green: 0.8247622848, blue: 0.9853010774, alpha: 1)
        if let nb = news.msg_nb {
            msgNbLabel.text = "\(nb)"
        }
        else {
            msgNbLabel.text = "1"
        }

        if news.isRead != nil && news.isRead! {
            configureIsRead()
        }
        else {
            readIndicator.backgroundColor = #colorLiteral(red: 0.3430494666, green: 0.8636034131, blue: 0.467017293, alpha: 1)
            subjectLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        }
        tagCollectionView.reloadData()
    }
    
    func configureIsRead() {
        readIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        subjectLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    }
    
    // MARK: - Tag Collection View Data Source
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if tags.isEmpty {
            return 0
        }
        return tags.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func getSizeOfText(string: String?) -> CGSize {
        let font = UIFont.systemFont(ofSize: 13, weight: .bold)
        let fontAttributes = [NSAttributedStringKey.font: font]
        let size = (string! as NSString).size(withAttributes: fontAttributes)
        return CGSize(width: size.width + 8, height: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getSizeOfText(string: tags[indexPath.row].tagName)
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TagCVCell", for: indexPath) as! TagCVCell
        
        let index = tags[indexPath.row]
        cell.tagColorView.backgroundColor = index.attributedColor
        cell.tagLabel.text = index.tagName
        return cell
    }
    
}

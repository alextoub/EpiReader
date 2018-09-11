//
//  TopicCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class TopicCell: UITableViewCell {
    
    // MARK: - Outlets
    
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var newsView: CustomView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var student: Student?
    
    // MARK: - Cell delegates
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ topic: Topic) {
        newsView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        authorLabel.text = parseAuthor((topic.author)!)[0]
        var parsedContent = topic.content
        if let content = topic.content {
            if PGPParser().isPgp(content: content) {
                parsedContent = PGPParser().parsePGP(content: content)
            }
        }
        contentText.text = parsedContent
        subjectLabel.text = topic.subject
        dateLabel.text = StrToAbrevWithHour(dateStr: (topic.creation_date)!)
        
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1).cgColor
        
        var author = parseAuthor((topic.author)!)
        
        var is_student = false
        let login = parseLogin(author[1])
        
        if let tmp = get_student_by(mail: author[1]) {
            student = tmp
            is_student = true
        }
        else if let tmp = get_student_by(login: login) {
            student = tmp
            is_student = true
        }
        else if let tmp = get_student_by(name: author[0]) {
            student = tmp
            is_student = true
        }
        else {
            is_student = false
        }
        
        if is_student {
            authorLabel.text = (student?.firstName!)! + " " + (student?.lastName)!
            photoImageView.af_setImage(withURL: URL(string: (student?.photo!)!)!, placeholderImage: #imageLiteral(resourceName: "default_picture"))
        }
        else {
            photoImageView.image = #imageLiteral(resourceName: "default_picture")
            
            let year = getYear(dateStr: (topic.creation_date)!)
            if year != nil {
                if let isAcu = isACU(mail: (parseAuthor((topic.author)!)[1])) {
                    if isAcu {
                        if (Assistant.ACU[year!] != nil) {
                            photoImageView.image = Assistant.ACU[year!]
                        }
                    }
                    else {
                        if (Assistant.YAKA[year!] != nil) {
                            photoImageView.image = Assistant.YAKA[year!]
                        }
                    }
                }
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func isACU(mail: String) -> Bool? {
        if mail == "chef@tickets.acu.epita.fr" || mail == "chef@tickets.assistants.epita.fr" {
            return true
        }
        else if mail == "chefs@yaka.epita.fr" || mail == "chefs@tickets.yaka.epita.fr"{
            return false
        }
        else {
            return nil
        }
    }
}

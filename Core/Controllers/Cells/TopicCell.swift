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
    
    // MARK: - Cell delegates
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(_ topic: Topic) {
        newsView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        contentText.text = topic.content
        subjectLabel.text = topic.subject
        dateLabel.text = StrToAbrevWithHour(dateStr: (topic.creation_date)!)
        
        photoImageView.layer.masksToBounds = true
        photoImageView.layer.cornerRadius = photoImageView.bounds.height / 2
        photoImageView.layer.borderWidth = 1
        photoImageView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1).cgColor
        
        var author = parseAuthor((topic.author)!)
        
        var is_student = false
        
        var student = Student()
        
        if let tmp = get_student_by(mail: author[1]) {
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
            authorLabel.text = student.firstName! + " " + student.lastName!
            photoImageView.af_setImage(withURL: URL(string: student.photo!)!, placeholderImage: #imageLiteral(resourceName: "default_picture"))
        }
        else {
            authorLabel.text = author[0]
            let url = getProfilePic(mail: author[1], subject: topic.subject!)
            photoImageView.af_setImage(withURL: url!, placeholderImage: #imageLiteral(resourceName: "default_picture"))
            
            if (author[1] == "chefs@yaka.epita.fr") {
                photoImageView.image = #imageLiteral(resourceName: "chefs")
            }
            if (author[1] == "chef@tickets.acu.epita.fr") {
                photoImageView.image = #imageLiteral(resourceName: "acu")
            }
            
            if photoImageView.image == nil {
                print("oui c nil")
            }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

//
//  TopicTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import SVProgressHUD
import AlamofireImage

class TopicTVC: UITableViewController {

    // MARK: - Global variables

    var nb_msg = 1
    var idNews: Int?
    var topic: Topic?
    var current: Topic?
    var index = 0
    var sizeCells = [CGFloat]()
    var topics = [Topic]()
    var errors = [ErrorNetiquette]()
    var isNetiquetteCheckerActivated = true

    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTopic()
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    // MARK: - Call functions
    
    func parse_topic(topic: Topic) {
        let topicTmp = Topic(id: topic.id, uid: topic.uid, author: topic.author, subject: topic.subject, content: topic.content, creation_date: topic.creation_date, groups: topic.groups)
        topics.append(topicTmp)
        
        for i in topic.children! {
            parse_topic(topic: i)
        }
    }
    
    func createArrayOfTopics() {
        parse_topic(topic: topic!)
        nb_msg = topics.count
    }

    func getTopic(){
        MainBusiness.getTopics(id: idNews!) { (response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.topic = response
                    self.current = self.topic
                    self.createArrayOfTopics()
                    self.index = 0
                    self.setupSizeCells()
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                    if self.isNetiquetteCheckerActivated {
                        self.setupNetiquetteErrors(topics: self.topics)
                    }
                }
                else
                {
                    SVProgressHUD.showError(withStatus: "Une erreur s'est produite")
                }
            }
        }
    }

    // MARK: - Custom functions

    func setupSizeCells() {
        var i = 0
        sizeCells.removeAll()
        if nb_msg == 0 {
            sizeCells.append(195.0)
        }
        while i < nb_msg * 2 {
            sizeCells.append(195.0)
            i += 1
        }
    }

    func setupTopic() {
        getTopic()
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Chargement en cours")
    }

    func setupTextNetiquette(error: ErrorNetiquette) -> String {
        var text = ""
        if error.errors.isEmpty && error.errors.isEmpty {
            text = "✅ La news semble conforme à la netiquette"
        }
        else {
            if !error.errors.isEmpty {
                var count = 0
                for i in error.errors {
                    text.append("🚫 \(i)")
                    count += 1
                    if count < error.errors.count {
                        text.append("\n\n")
                    }
                }
            }
            if !error.warnings.isEmpty {
                text.append("\n\n")
                var count = 0
                for i in error.warnings {
                    text.append("⚠️ \(i)")
                    count += 1
                    if count < error.warnings.count {
                        text.append("\n\n")
                    }
                }
            }
        }
        return text
    }

    func setupNetiquetteErrors(topics: [Topic]) {
        for topic in topics {
            errors.append(NetiquetteChecker().checkNews(topic: topic))
        }
        print(errors)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if nb_msg == 0 {
            return 0
        }
        if isNetiquetteCheckerActivated {
            return nb_msg * 2
        }
        else {
            return nb_msg
        }
    }

    @IBAction func shareButtonAction(_ sender: Any) {
        let vc = UIActivityViewController(activityItems: [current?.subject ?? "", current?.author ?? "", current?.content ?? ""], applicationActivities: nil)
        self.present(vc, animated: true, completion: nil)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if isNetiquetteCheckerActivated {
            if indexPath.row % 2 == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
                guard (topics.count > 0) else {
                    return cell
                }
                let index = topics[indexPath.row / 2]
                
                cell.configure(index)
                
                if sizeCells[indexPath.row] == 195.0 {
                    var newContentText = cell.contentText.frame
                    newContentText.size.width = cell.contentText.contentSize.width
                    newContentText.size.height = cell.contentText.contentSize.height
                    cell.contentText.frame = newContentText
                    sizeCells[indexPath.row] = cell.contentText.contentSize.height
                }
                cell.contentText.sizeThatFits(CGSize(width: cell.contentText.contentSize.width, height: cell.contentText.contentSize.height))
                cell.contentText.isScrollEnabled = false
                
                return cell
            }
            else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "NetiquetteCell", for: indexPath) as! NetiquetteCell
                guard (topics.count > 0) else {
                    return cell
                }
                let index = errors[indexPath.row / 2]
                cell.newsView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
                
                cell.contentTextView.text = setupTextNetiquette(error: index)
                
                if sizeCells[indexPath.row] == 195.0 {
                    print(cell.contentTextView.frame)
                    var newContentText = cell.contentTextView.frame
                    newContentText.size.width = cell.contentTextView.contentSize.width
                    newContentText.size.height = cell.contentTextView.contentSize.height
                    cell.contentTextView.frame = newContentText
                    sizeCells[indexPath.row] = cell.contentTextView.contentSize.height
                }
                cell.contentTextView.sizeThatFits(CGSize(width: cell.contentTextView.contentSize.width, height: cell.contentTextView.contentSize.height))
                cell.contentTextView.isScrollEnabled = false
                
                return cell
                
            }
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
            guard (topics.count > 0) else {
                return cell
            }
            let index = topics[indexPath.row]
            cell.configure(index)
            if sizeCells[indexPath.row] == 195.0 {
                var newContentText = cell.contentText.frame
                newContentText.size.width = cell.contentText.contentSize.width
                newContentText.size.height = cell.contentText.contentSize.height
                cell.contentText.frame = newContentText
                sizeCells[indexPath.row] = cell.contentText.contentSize.height
            }
            cell.contentText.sizeThatFits(CGSize(width: cell.contentText.contentSize.width, height: cell.contentText.contentSize.height))
            cell.contentText.isScrollEnabled = false
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard (sizeCells.count > 0) else {
            return 195
        }
        if isNetiquetteCheckerActivated {
            if indexPath.row % 2 == 0 {
                return 195 - 128 + sizeCells[indexPath.row]
            }
            else {
                return 30 + sizeCells[indexPath.row]
            }
        }
        else {
            return 195 - 128 + sizeCells[indexPath.row]
        }
        //return 3000
    }
    
    @IBAction func openStudentView(_ sender: Any) {
        
        
        let viewPos : CGPoint = (sender as AnyObject).convert(CGPoint.zero , to: self.tableView)
        let indexPath = self.tableView.indexPathForRow(at: viewPos)
        let cell = tableView.cellForRow(at: indexPath!) as! TopicCell
        if cell.student != nil {
            let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ImageVC") as! ImageVC
            vc.modalTransitionStyle = .coverVertical
            vc.modalPresentationStyle = .overCurrentContext

            vc.image = cell.photoImageView.image!
            vc.student = cell.student!
        
            present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showImage" {
//            let viewPos : CGPoint = (sender as AnyObject).convert(CGPoint.zero , to: self.tableView)
//            let indexPath = self.tableView.indexPathForRow(at: viewPos)
//            let vc = segue.destination as! ImageVC
//            let cell = tableView.cellForRow(at: indexPath!) as! TopicCell
//            vc.image = cell.photoImageView.image!
//            vc.student = cell.student
//        }
//    }

}

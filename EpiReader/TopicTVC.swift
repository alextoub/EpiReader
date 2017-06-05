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
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTopic()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Call functions
  
  func getTopic(){
    MainBusiness.getTopics(id: idNews!) { (response, error) in
      DispatchQueue.main.async {
        if error == nil {
          self.topic = response
          self.current = self.topic
          self.index = 0
          self.setupSizeCells()
          self.tableView.reloadData()
          SVProgressHUD.dismiss()
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
    while i < nb_msg {
      sizeCells.append(195.0)
      i += 1
    }
  }
  
  func setupTopic() {
    getTopic()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show(withStatus: "Chargement en cours")
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if nb_msg == 0 {
      return 1
    }
    else {
      return nb_msg
    }
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
    guard (current != nil) else {
      return cell
    }
    print(cell.bounds.height)
    
    cell.authorLabel.text = parseAuthor((current?.author)!)[0]
    cell.contentText.text = current?.content
    cell.subjectLabel.text = current?.subject
    cell.dateLabel.text = StrToAbrevWithHour(dateStr: (current?.creation_date)!)
    let url = URL(string: "https://photos.cri.epita.net/" + parseLogin(parseAuthor((current?.author)!)[1]) + "-thumb")
    cell.photoImageView.af_setImage(withURL: url!, placeholderImage: #imageLiteral(resourceName: "default_picture"))

    if (parseAuthor((current?.author)!)[1] == "chefs@yaka.epita.fr") {
      cell.photoImageView.image = #imageLiteral(resourceName: "chefs")
    }
    
    if cell.photoImageView.image == nil {
      print("oui c nil")
    }
    
    cell.displayCell()
    
    sizeCells[indexPath.row] = cell.contentText.contentSize.height
    cell.contentText.sizeThatFits(CGSize(width: cell.contentText.contentSize.width, height: cell.contentText.contentSize.height))
    cell.contentText.isScrollEnabled = false
    if (current?.children?.count)! > 0 {
      current = current?.children?[0]
      nb_msg += 1
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard (sizeCells.count > 0) else {
      return 195
    }
    return 195 - 128 + sizeCells[indexPath.row]
  }
  
}

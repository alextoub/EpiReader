//
//  TopicTVC.swift
//  EpiNotifier
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import SVProgressHUD

class TopicTVC: UITableViewController {
  
  var nb_msg = 1
  var idNews: Int?
  var topic: Topic?
  var current: Topic?
  var index = 0
  var sizeCells = [CGFloat]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTopic()
  }
  
  func setupSizeCells() {
    var i = 0
    while i < nb_msg {
      sizeCells.append(195.0)
      i += 1
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func setupTopic() {
    getTopic()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show(withStatus: "Chargement en cours")
  }
  
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
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return nb_msg
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
    sizeCells[indexPath.row] = cell.contentText.contentSize.height
    cell.contentText.sizeThatFits(CGSize(width: cell.contentText.contentSize.width, height: cell.contentText.contentSize.height))
    cell.contentText.isScrollEnabled = false
    if nb_msg > 1 && index < nb_msg - 1 {
      current = current?.children?[index]
      index += 1
    }
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard (sizeCells.count > 0) else {
      return 195
    }
    return 195 - 141 + sizeCells[indexPath.row]
  }
  
}

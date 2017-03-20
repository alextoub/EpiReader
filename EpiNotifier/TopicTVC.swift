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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTopic()
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
    cell.authorLabel.text = current?.author
    cell.contentText.text = current?.content
    cell.subjectLabel.text = current?.subject
    cell.dateLabel.text = current?.creation_date
    let size = UITableViewAutomaticDimension
    cell.newsView.frame = CGRect(x: cell.newsView.bounds.minX, y: cell.newsView.bounds.minY, width: cell.newsView.bounds.width, height: size - 10)
    //cell.newsView.bounds.height = UITableViewAutomaticDimension - 10
    if nb_msg > 1 && index < nb_msg - 1 {
      current = current?.children?[index]
      index += 1
    }
    return cell
  }
  
}

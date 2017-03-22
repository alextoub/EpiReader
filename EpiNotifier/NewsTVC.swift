//
//  NewsTVC.swift
//  EpiNotifier
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh

class NewsTVC: UITableViewController {
  
  // MARK: - Global variables
  
  var news = [News]()
  var currentGroup = ""
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNews()
    self.title = currentGroup
    self.tableView.es_addPullToRefresh {
      self.setupNews()
      self.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Call functions
  
  func getNews(){
    MainBusiness.getNews(group: currentGroup, nb: 25) { (response, error) in
      DispatchQueue.main.async {
        if error == nil {
          self.news = response!
          self.tableView.reloadData()
          SVProgressHUD.dismiss()
        }
      }
    }
  }
  
  // MARK: - Custom functions
  
  func setupNews() {
    getNews()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show(withStatus: "Chargement en cours")
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
    let index = news[indexPath.row]
    let authorArr = parseAuthor(index.author!)
    cell.authorLabel.text = authorArr[0]
    cell.mailLabel.text = authorArr[1]
    cell.readIndicator.layer.masksToBounds = true
    cell.readIndicator.layer.cornerRadius = cell.readIndicator.bounds.height / 2
    cell.dateLabel.text = StrToAbrev(dateStr: index.creation_date!)
    cell.subjectLabel.text = index.subject
    if index.msg_nb! > 1 {
      cell.msgNbIndicator.image = #imageLiteral(resourceName: "DoubleArrow")
    }
    else {
      cell.msgNbIndicator.image = #imageLiteral(resourceName: "SingleArrow")
    }
    
    return cell
  }
  
  // MARK: - Navigation
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toTopic" {
      let destination = segue.destination as! TopicTVC
      let indexPath = tableView.indexPathForSelectedRow
      destination.idNews = news[(indexPath?.row)!].id!
      destination.nb_msg = news[(indexPath?.row)!].msg_nb!
    }
  }
  
}

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
  var readNews = [ReadNews]()
  
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
  
  override func viewWillAppear(_ animated: Bool) {
    getNews()
    getReadNews()
    tableView.reloadData()
  }
  
  func getReadNews() {
    readNews.removeAll()
    if let readNew = loadReadNews() {
      readNews += readNew
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
          self.checkIfRead()
          self.tableView.reloadData()
          SVProgressHUD.dismiss()
        }
      }
    }
  }
  
  // MARK: - NSCoding functions
  
  private func saveReadNews() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(readNews, toFile: ReadNews.ArchiveURL.path)
    if isSuccessfulSave {
      print("ReadNews successfully saved.")
    } else {
      print("Failed to save readNews...")
    }
  }
  
  private func loadReadNews() -> [ReadNews]?  {
    print(ReadNews.ArchiveURL.path)
    return NSKeyedUnarchiver.unarchiveObject(withFile: ReadNews.ArchiveURL.path) as? [ReadNews]
  }
  
  // MARK: - Custom functions
  
  func setupNews() {
    getNews()
    getReadNews()
    tableView.reloadData()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show(withStatus: "Chargement en cours")
  }
  
  func checkIfRead() {
    for new in news {
      new.isRead = false
      for read in readNews {
        if read.id == new.id! {
          new.isRead = true
        }
      }
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return news.count
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let index = news[indexPath.row]
    readNews.append(ReadNews(id : index.id!))
    saveReadNews()
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
      cell.msgNbIndicator.image = #imageLiteral(resourceName: "double_arrow_green")
    }
    else {
      cell.msgNbIndicator.image = #imageLiteral(resourceName: "single_arrow")
    }
    if index.isRead != nil && index.isRead! {
      cell.readIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
      if cell.msgNbIndicator.image == #imageLiteral(resourceName: "double_arrow_green"){
        cell.msgNbIndicator.image = #imageLiteral(resourceName: "double_arrow_grey")
      }
    }
    else {
      cell.readIndicator.backgroundColor = #colorLiteral(red: 0.3430494666, green: 0.8636034131, blue: 0.467017293, alpha: 1)

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

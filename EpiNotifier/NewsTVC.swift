//
//  NewsTVC.swift
//  EpiNotifier
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import SVProgressHUD

class NewsTVC: UITableViewController {
  
  var news = [News]()
  var currentGroup = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupNews()
    self.title = currentGroup
  }
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func setupNews() {
    getNews()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show(withStatus: "Chargement en cours")
  }
  
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
    cell.authorLabel.text = index.author
    cell.readIndicator.layer.masksToBounds = true
    cell.readIndicator.layer.cornerRadius = cell.readIndicator.bounds.height / 2
    cell.dateLabel.text = index.creation_date
    cell.subjectLabel.text = index.subject
    
    return cell
  }
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
}

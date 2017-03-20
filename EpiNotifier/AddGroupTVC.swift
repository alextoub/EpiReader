//
//  AddGroupTVC.swift
//  EpiNotifier
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import SVProgressHUD

class AddGroupTVC: UITableViewController {
  
  var groups = [Group]()
  var favorites = [Favorite]()
  var favGroupName = [String]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupGroup()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func fillGroupNames() {
    for fav in favorites {
      favGroupName.append(fav.group_name!)
    }
  }
  
  private func saveFavorites() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(favorites, toFile: Favorite.ArchiveURL.path)
    if isSuccessfulSave {
      print("Favorites successfully saved.")
    } else {
      print("Failed to save favorites...")
    }
  }
  
  func setupGroup() {
    getGroups()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show(withStatus: "Chargement en cours")
  }
  
  func getGroups(){
    MainBusiness.getGroups { (response, error) in
      DispatchQueue.main.async {
        if error == nil {
          self.groups = response!
          self.tableView.reloadData()
          self.fillGroupNames()
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
    return groups.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "AddGroupCell", for: indexPath) as! AddGroupCell
    let index = groups[indexPath.row]
    cell.groupNameLabel.text = index.group_name
    if favGroupName.contains(index.group_name!) {
      cell.isFavoriteSwitch.isOn = true
    }
    cell.isFavoriteSwitch.addTarget(self, action: #selector(addToFav), for: .touchUpInside)
    cell.isFavoriteSwitch.tag = indexPath.row
    
    return cell
  }
  
  func addToFav(sender: UISwitch) {
    var i = 0
    let obj = groups[sender.tag]
    if !sender.isOn {
      for fav in favGroupName {
        if fav == obj.group_name {
          favorites.remove(at: i)
          break
        }
        i += 1
      }
    }
    else {
    favorites.append(Favorite(id: obj.id!, group_name: obj.group_name!, topic_nb: obj.topic_nb!, available: obj.available!))
    }
    saveFavorites()
  }
}

//
//  MainTVC.swift
//  EpiNotifier
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class MainTVC: UITableViewController {
  
  var favorites = [Favorite]()
  var selected = ""
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    if let fav = loadFavorites() {
      favorites += fav
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  private func saveFavorites() {
    let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(favorites, toFile: Favorite.ArchiveURL.path)
    if isSuccessfulSave {
      print("Favorites successfully saved.")
    } else {
      print("Failed to save favorites...")
    }
  }
  
  private func loadFavorites() -> [Favorite]?  {
    print(Favorite.ArchiveURL.path)
    return NSKeyedUnarchiver.unarchiveObject(withFile: Favorite.ArchiveURL.path) as? [Favorite]
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return favorites.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
    let index = favorites[indexPath.row]
    cell.groupNameLabel.text = index.group_name
    cell.nbNewsLabel.text = String(describing: index.topic_nb!)
    
    cell.groupView.layer.masksToBounds = true
    cell.groupView.layer.cornerRadius = cell.groupView.bounds.height / 2
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "toAdd" {
      let destination = segue.destination as! AddGroupTVC
      destination.favorites = favorites
    }
    else if segue.identifier == "toNews" {
      let destination = segue.destination as! NewsTVC
      let indexPath = tableView.indexPathForSelectedRow
      destination.currentGroup = favorites[(indexPath?.row)!].group_name!
    }
  }
  
}

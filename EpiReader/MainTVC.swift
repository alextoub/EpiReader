//
//  MainTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import ESPullToRefresh

class MainTVC: UITableViewController {
    
    // MARK: - Global variables
    
    var favorites = [Favorite]()
    var selected = ""
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.es_addPullToRefresh {
            self.getFav()
            self.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }

    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFav()
        navigationController?.isToolbarHidden = true

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Custom functions
    
    func getFav() {
        favorites.removeAll()
        if let fav = NSCodingData().loadFavorites() {
            favorites += fav
            tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites.count == 0 {
            return 1
        }
        return favorites.count
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.remove(at: indexPath.row)
            if favorites.count != 0 {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            else {
                tableView.reloadData()
            }
            NSCodingData().saveFavorites(favorites: favorites)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if favorites.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "NoGroupCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        let index = favorites[indexPath.row]
        cell.setupCell(favorite: index)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if favorites.count == 0 {
            return 140.0
        }
        return 71.0
    }
    
    // MARK: - Navigation
    
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

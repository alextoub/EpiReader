//
//  SearchTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 26/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class SearchTVC: UITableViewController {
    
    // MARK: - Variables
    
    let searchController = UISearchController(searchResultsController: nil)
    var items = [News]()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
    }
    
    // MARK: - Custom functions
    
    func configureSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 39.0/255.0, green: 203.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.placeholder = "Search item"
        searchController.searchBar.delegate = self
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath)

        cell.textLabel?.text = items[indexPath.row].subject

        return cell
    }
}

extension SearchTVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MainBusiness.getSearch(term: (searchController.searchBar.text?.replacingOccurrences(of: " ", with: "+"))!) { (response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.items = response!
                    self.tableView.reloadData()
                }
            }
        }
    }
}

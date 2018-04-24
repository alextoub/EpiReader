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
    var tags = [Tag]()
    var readNews = [ReadNews]()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - Custom functions
    
    func configureSearchController() {
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.barTintColor = UIColor(red: 39.0/255.0, green: 203.0/255.0, blue: 192.0/255.0, alpha: 1.0)
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.placeholder = NSLocale.preferredLanguages[0].range(of:"fr") != nil ? "Rechercher une news" : "Search a news"
        searchController.searchBar.delegate = self
    }
    
    // MARK: - Custom method
    
    func setupSubject(_ subject: String) -> ([Tag], String) {
        let parsedSubject = parse(subjectStr: subject)
        
        var tagsTmp = [Tag]()
        
        for i in parsedSubject.0 {
            let tag = check(tag: i, in: tags)
            
            if !tag.1 {
                addToTags(tag: tag.0)
            }
            
            tagsTmp.append(tag.0)
        }
        
        return (tagsTmp, parsedSubject.1.trimmingCharacters(in: .whitespacesAndNewlines))
    }
    
    // MARK: - NSCoding Data
    
    func getReadNews() {
        readNews.removeAll()
        if let readNew = NSCodingData().loadReadNews() {
            readNews += readNew
        }
    }
    
    func getTags() {
        tags.removeAll()
        if let tag = NSCodingData().loadTag() {
            tags += tag
        }
    }
    
    func addToTags(tag: Tag) {
        tags.append(tag)
        NSCodingData().saveTag(tags: tags)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.row < self.items.count else {
            return
        }
        
        let index = items[indexPath.row]
        readNews.append(ReadNews(id : index.id!))
        index.isRead = true
        let cell = tableView.cellForRow(at: indexPath) as! NewsCell
        cell.configureIsRead()
        NSCodingData().saveReadNews(readNews: readNews)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        let index = items[indexPath.row]
        let subjectSetup = setupSubject(index.subject!)
        cell.tags = subjectSetup.0
        cell.configure(index)
        
        return cell
    }
    
    // MARK : - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTopic" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let destination = segue.destination as! TopicTVC
            destination.idNews = items[(indexPath.row)].id!
            destination.nb_msg = items[(indexPath.row)].msg_nb!
            if title == "assistants.news" || !(UserDefaults.standard.bool(forKey: "CNEnabled")) {
                destination.isNetiquetteCheckerActivated = false
            }
        }
    }
}

extension SearchTVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        MainBusiness.getSearch(term: (searchController.searchBar.text?.replacingOccurrences(of: " ", with: "+"))!) { (response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.items = response!
                    self.getTags()
                    self.tableView.reloadData()
                }
            }
        }
    }
}

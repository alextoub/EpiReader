//
//  SettingTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 05/06/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {
    
    // MARK: - Variables
    
    @IBOutlet weak var separatorView: UIView!
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Custom functions
    
    func setupTableView() {
        let cellHeight: CGFloat = 44
        self.tableView.estimatedRowHeight = cellHeight
        self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.alwaysBounceVertical = false
    }
    
    func setupOptionCell(identifier: String, indexPath: IndexPath, text: String) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        cell.textLabel?.text = text
        return cell
    }
    
    func setupDefaultCell(identifier: String, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        return cell
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfOptions: Int = 4
        return numberOfOptions
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as IndexPath).row {
        case 0 :
            return setupOptionCell(identifier: "aboutCell", indexPath: indexPath, text: "À propos")
        case 1 :
            return setupOptionCell(identifier: "notificationCell", indexPath: indexPath, text: "Notifications")
        case 2 :
            return setupOptionCell(identifier: "tagCell", indexPath: indexPath, text: "Balises")
            //return setupDefaultCell(identifier: "cell", indexPath: indexPath)
            //return setupOptionCell(identifier: "themeCell", indexPath: indexPath, text: "Thème")
        case 3 :
            return setupDefaultCell(identifier: "cell", indexPath: indexPath)
        case 4 :
            return setupOptionCell(identifier: "cacheCell", indexPath: indexPath, text: "Cache")
        default:
            return setupDefaultCell(identifier: "reuseIdentifier", indexPath: indexPath)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 2 {
            return false
        }
        return true
    }
}

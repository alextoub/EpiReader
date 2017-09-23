//
//  SettingTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 05/06/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {
    
    @IBOutlet weak var separatorView: UIView!
    
    // MARK: - View LifeCycle
    
    /**
     Set graphical element parameters
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: - Setup
    
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
    
    // MARK: - Table view delegates
    
    /**
     Get the number of section in tableview
     
     - parameter tableView: the tableview
     
     - returns: the number of section in tableview
     */
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    /**
     Get the number of rows in a particular section
     
     - parameter tableView: the tableview
     - parameter section: the particular section
     
     - returns: the number of rows in the section
     */
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfOptions: Int = 3
        return numberOfOptions
    }
    
    /**
     Get the cell content a indexPath
     
     - parameter tableView: the tableview
     - parameter cellForRowAt: the indexPath of the cell
     
     - returns: the cell defined with its content and color
     */
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as IndexPath).row {
        case 0 :
            return setupOptionCell(identifier: "aboutCell", indexPath: indexPath, text: "À propos")
        case 1 :
            return setupOptionCell(identifier: "notificationCell", indexPath: indexPath, text: "Notifications")
        case 2 :
            return setupDefaultCell(identifier: "cell", indexPath: indexPath)
            //return setupOptionCell(identifier: "themeCell", indexPath: indexPath, text: "Thème")
        case 3 :
            return setupOptionCell(identifier: "tagCell", indexPath: indexPath, text: "Balises")
        case 4 :
            return setupOptionCell(identifier: "cacheCell", indexPath: indexPath, text: "Cache")
        default:
            return setupDefaultCell(identifier: "reuseIdentifier", indexPath: indexPath)
        }
    }
    
    /**
     Called when a cell is selected
     
     - parameter tableView: the tableview
     - parameter didSelectRowAt: the indexPath of the selected cell
     */
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

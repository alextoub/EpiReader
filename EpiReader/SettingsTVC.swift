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
    
    
//    // MARK: - View LifeCycle
//
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupTableView()
    }
//
//    // MARK: - Custom functions
//
//    func setupTableView() {
//        let cellHeight: CGFloat = 44
//        self.tableView.estimatedRowHeight = cellHeight
//        self.tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.alwaysBounceVertical = false
//    }
//
//    func setupOptionCell(identifier: String, indexPath: IndexPath, text: String) -> UITableViewCell {
//        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        cell.textLabel?.text = text
//        return cell
//    }
//
//    func setupDefaultCell(identifier: String, indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//        return cell
//    }
//
//    // MARK: - Table view data source
//
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
//
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfOptions: Int = 4
        return numberOfOptions
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath as IndexPath).row {
        case 0 :
            let cell = tableView.dequeueReusableCell(withIdentifier: "IdentityCell") as! IdentityCell
            cell.configure()
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! UITableViewCell
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
            cell.configure(title: "Notifications", color: #colorLiteral(red: 0.3430494666, green: 0.8636034131, blue: 0.467017293, alpha: 1), image: #imageLiteral(resourceName: "notification_logo"))
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell") as! SettingCell
            cell.configure(title: "Balises", color: #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2784313725, alpha: 1), image: #imageLiteral(resourceName: "tags_logo"))
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! UITableViewCell
            return cell
        }
    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        switch (indexPath as IndexPath).row {
//        case 0 :
//            return setupOptionCell(identifier: "aboutCell", indexPath: indexPath, text: "À propos")
//        case 1 :
//            return setupOptionCell(identifier: "notificationCell", indexPath: indexPath, text: "Notifications")
//        case 2 :
//            return setupOptionCell(identifier: "tagCell", indexPath: indexPath, text: "Balises")
//            //return setupDefaultCell(identifier: "cell", indexPath: indexPath)
//            //return setupOptionCell(identifier: "themeCell", indexPath: indexPath, text: "Thème")
//        case 3 :
//            return setupDefaultCell(identifier: "cell", indexPath: indexPath)
//        case 4 :
//            return setupOptionCell(identifier: "cacheCell", indexPath: indexPath, text: "Cache")
//        default:
//            return setupDefaultCell(identifier: "reuseIdentifier", indexPath: indexPath)
//        }
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//    }
//
//    override func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {
//        if indexPath.row == 2 {
//            return false
//        }
//        return true
//    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 191.0
        }
        else if indexPath.row == 1 {
            return 10.0
        }
        else {
            return 70.0
        }
    }
}

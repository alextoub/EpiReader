//
//  SettingTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 05/06/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 191
        }
        else if indexPath.row == 1 {
            return 10.0
        }
        else {
            return 70.0
        }
    }
}

//
//  NotificationTVC.swift
//  EpiReader
//
//  Created by Alex Toubiana on 9/23/17.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class NotificationTVC: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaticData.notificationsGroups.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        
        let index = StaticData.notificationsGroups[indexPath.row]
        
        cell.textLabel?.text = index
        

        return cell
    }
}

//
//  SettingTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 05/06/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import Crashlytics

class SettingsTVC: UITableViewController {

    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Answers.logContentView(withName: "Open settings view", contentType: "", contentId: "settings")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.settings.count + 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as IndexPath).row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "IdentityCell") as! IdentityCell
            cell.configure()
            return cell
        } else if (indexPath as IndexPath).row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell")
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
            let setting = Constants.settings[(indexPath as IndexPath).row - 2]
            //cell.configure(title: setting.title, color: setting.color, image: setting.image)
            cell.configure(setting: setting)
            return cell
        }
//
//        switch (indexPath as IndexPath).row {
//        case 0 :
//            let cell = tableView.dequeueReusableCell(withIdentifier: "IdentityCell") as! IdentityCell
//            cell.configure()
//            return cell
//        case 1:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! UITableViewCell
//            return cell
//        case 2:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell") as! SettingCell
//            cell.configure(title: "Notifications", color: #colorLiteral(red: 0.3430494666, green: 0.8636034131, blue: 0.467017293, alpha: 1), image: #imageLiteral(resourceName: "notification_logo"))
//            return cell
//        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "TagCell") as! SettingCell
//            cell.configure(title: "Balises", color: #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2784313725, alpha: 1), image: #imageLiteral(resourceName: "tags_logo"))
//            return cell
//        case 4:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "EnableCNCell") as! SettingCell
//            cell.configure(title: "Vérifier nétiquette [BETA]", color: #colorLiteral(red: 0.3529411765, green: 0.7843137255, blue: 0.9803921569, alpha: 1), image: #imageLiteral(resourceName: "netiquette_logo"))
//            return cell
//        default:
//            let cell = tableView.dequeueReusableCell(withIdentifier: "EmptyCell") as! UITableViewCell
//            return cell
       // }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath as IndexPath).row < 2 {
            return
        }
        if (Constants.settings[(indexPath as IndexPath).row - 2].viewPush != "")
        {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let destination = storyboard.instantiateViewController(withIdentifier: Constants.settings[(indexPath as IndexPath).row - 2].viewPush)
            navigationController?.pushViewController(destination, animated: true)
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

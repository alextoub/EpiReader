//
//  TagsTVC.swift
//  EpiReader
//
//  Created by Alex Toubiana on 9/24/17.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class TagsTVC: UITableViewController {
    
    var tags = [Tag]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let tag = NSCodingData().loadTag() {
            tags = tag
            tags.sort(by: { $0.tagName! < $1.tagName! })
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagCell", for: indexPath) as! TagCell
        
        let index = tags[indexPath.row]
        
        cell.colorView.layer.masksToBounds = true
        cell.colorView.layer.cornerRadius = cell.colorView.bounds.height / 2
        
        cell.colorView.backgroundColor = index.attributedColor
        cell.nameLabel.text = index.tagName
        
        
        return cell
    }
    
     // MARK: - Navigation
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showTag" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let destination = segue.destination as! TagAlertVC
            destination.tagName = self.tags[indexPath.row].tagName!
            destination.tagColor = self.tags[indexPath.row].attributedColor!
        }
     }
    
}


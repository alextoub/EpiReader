//
//  TagsTVC.swift
//  EpiReader
//
//  Created by Alex Toubiana on 9/24/17.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class TagsTVC: UITableViewController {
    
    // MARK: - Variables
    
    var tags = [Tag]()
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTag()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Custom functions
    
    func loadTag() {
        if let tag = NSCodingData().loadTag() {
            tags = tag
            tags.sort(by: { $0.tagName! < $1.tagName! })
        }
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
        
        cell.configure(index)

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


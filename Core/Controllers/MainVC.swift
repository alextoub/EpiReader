//
//  MainVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import ESPullToRefresh
import ObjectMapper
import Alamofire
import Crashlytics

class MainVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return stories.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = storyCollectionView.dequeueReusableCell(withReuseIdentifier: "StoryCVCell", for: indexPath) as! StoryCVCell
        let index = stories[indexPath.row]
        cell.newsgroupLabel.text = index.newsgroup
        cell.userLabel.text = index.userName
        cell.userImageView.layer.masksToBounds = true
        cell.userImageView.layer.cornerRadius = cell.userImageView.frame.height / 2
        
        cell.userImageView.af_setImage(withURL: index.userImageUrl!, placeholderImage: #imageLiteral(resourceName: "default_picture"))
        
        return cell
        
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleStory: UILabel!
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    // MARK: - Global variables
    
    var stories = [Story]()
    var favorites = [Favorite]()
    var selected = ""
    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.es_addPullToRefresh {
            self.getFav()
            self.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
        self.getLastNews()
        
        // Code executed for update 1.2
        
        let deleteTags = UserDefaults.standard.bool(forKey: "deleteTags")
        if !deleteTags {
            NSCodingData().deleteTagFile()
            UserDefaults.standard.set(true, forKey: "deleteTags")
        }
        
        // End of code executed for update 1.2
        
        get_students()
        
        Answers.logContentView(withName: "Show newsgroup list", contentType: "List", contentId: "newsgroup_list")
        
        let CNEnabled = UserDefaults.standard.bool(forKey: "CNEnabled")
        if !CNEnabled {
            UserDefaults.standard.set(false, forKey: "CNEnabled")
        }
        
        let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
        if !isDarkMode {
            UserDefaults.standard.set(false, forKey: "isDarkMode")
        }

        
        //var students = Mapper<Student>().mapArray(
    }
    
    func get_students() {
        
        Alamofire.request(Constants.Hidden.STUDENTS_URL)
            .validate()
            .responseArray { (alamoResponse: DataResponse<[Student]>) in
                
                if alamoResponse.result.error == nil {
                    StaticData.students = alamoResponse.result.value
                }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFav()
        navigationController?.isToolbarHidden = true

    }
    
    // MARK: - Custom functions
    
    func getFav() {
        favorites.removeAll()
        if let fav = NSCodingData().loadFavorites() {
            favorites += fav
            tableView.reloadData()
        }
    }
    
    func getLastNews() {
        MainBusiness.getLastNews(nb: 25) { (response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    for resp in response! {
                        self.stories.append(resp.toStory())
                        self.storyCollectionView.reloadData()
                    }
                }
            }
        }
    }
    
    // MARK: - Table view data source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if favorites.count == 0 {
            return 1
        }
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return NSLocale.preferredLanguages[0].range(of:"fr") != nil ? "Supprimer" : "Delete"
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            favorites.remove(at: indexPath.row)
            if favorites.count != 0 {
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            else {
                tableView.reloadData()
            }
            NSCodingData().saveFavorites(favorites: favorites)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if favorites.count == 0 {
            return tableView.dequeueReusableCell(withIdentifier: "NoGroupCell")!
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "GroupCell", for: indexPath) as! GroupCell
        let index = favorites[indexPath.row]
        cell.setupCell(favorite: index)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if favorites.count == 0 {
            return 140.0
        }
        return 71.0
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAdd" {
            let destination = segue.destination as! AddGroupTVC
            destination.favorites = favorites
        }
        else if segue.identifier == "toNews" {
            let destination = segue.destination as! NewsTVC
            let indexPath = tableView.indexPathForSelectedRow
            destination.currentGroup = favorites[(indexPath?.row)!].group_name!
        }
    }
    
}

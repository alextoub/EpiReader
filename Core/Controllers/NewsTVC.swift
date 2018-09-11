//
//  NewsTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh
import GoogleMobileAds
import Crashlytics

class NewsTVC: UITableViewController {

    // MARK: - Global variables

    @IBOutlet weak var notificationButton: UIBarButtonItem!
    @IBOutlet weak var markAllAsReadButton: UIBarButtonItem!

    var news = [News]()
    var currentGroup = ""
    var readNews = [ReadNews]()
    var tags = [Tag]()
    var favorites = [Favorite]()
    var inNotif = false

    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = currentGroup

        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Chargement en cours")
        markAllAsReadButton.tintColor = .clear

        setupNews()
        inNotif = checkInNotifs(name: currentGroup)
        updateNotifButton()
        
//        updateMarkAllAsReadButton()
        
        self.tableView.es_addPullToRefresh {
            self.setupNews()
            self.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }
        
        Answers.logContentView(withName: "Show news list", contentType: "List", contentId: "news_\(currentGroup)")
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Call functions

    func getNews(){
        MainBusiness.getNews(group: currentGroup, nb: 25) { (response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.news = response!
                    self.checkIfRead()
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                } else {
                    SVProgressHUD.showError(withStatus: "Une erreur s'est produite")
                    SVProgressHUD.dismiss(withDelay: 0.5)
                }
                self.updateMarkAllAsReadButton()
            }
        }
    }

    func getNewsWithDate(date: String){
        MainBusiness.getNewsWithDate(group: currentGroup, nb: 25, date: date) { (response, error) in
            DispatchQueue.main.async {
                if error == nil {
                    self.news += response!
                    self.checkIfRead()
                    self.tableView.reloadData()
                    SVProgressHUD.dismiss()
                }
                else
                {
                    SVProgressHUD.showError(withStatus: "Une erreur s'est produite")
                }
            }

        }
    }
    
    // MARK: - Notification methods

    func checkInNotifs(name: String) -> Bool {
        return StaticData.notificationsGroups.contains(name)
    }

    func updateNotifButton() {
        if inNotif {
            notificationButton.image = #imageLiteral(resourceName: "notification_filled")
        }
        else {
            notificationButton.image = #imageLiteral(resourceName: "notification_not_filled")
        }
    }
    
    func updateMarkAllAsReadButton() {
        if let allReadDate = getLastAllReadDate(), let lastNewsDate = news.first?.creation_date, allReadDate > StrToDate(dateStr: lastNewsDate) {
            markAllAsReadButton.isEnabled = false
            markAllAsReadButton.tintColor = UIColor.clear
        } else {
            markAllAsReadButton.image = #imageLiteral(resourceName: "mark_all_as_read")
        }
    }

    // MARK: - Custom methods

    func setupNews() {
        getNews()
        getReadNews()
        getTags()
        tableView.reloadData()
    }

    func checkIfRead() {
        for new in news {
            new.isRead = false
            for read in readNews {
                if read.id == new.id! {
                    new.isRead = true
                }
            }
        }
    }
    
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
    
    func getLastAllReadDate() -> Date? {
        return NSCodingData().loadLastAllReadDate(group: currentGroup)
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
    
    // MARK: - IBActions
    
    @IBAction func notificationButtonAction(_ sender: Any) {
        if !inNotif {
            MainBusiness.postSubscribeNotification(service: "ios", registration_id: StaticData.deviceToken, host: "news.epita.fr", newsgroup: currentGroup) { (response, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        StaticData.notificationsGroups.append(self.currentGroup)
                    }
                }
                Answers.logCustomEvent(withName: "Add to notifications",
                                       customAttributes: ["name_group":"\(self.currentGroup)"])
            }
        }
        else {
            MainBusiness.postUnsubscribeNotification(service: "ios", registration_id: StaticData.deviceToken, host: "news.epita.fr", newsgroup: currentGroup) { (response, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        if let index = StaticData.notificationsGroups.index(of: self.currentGroup) {
                            StaticData.notificationsGroups.remove(at: index)
                        }
                    }
                }
                Answers.logCustomEvent(withName: "Remove of notifications",
                                       customAttributes: ["name_group":"\(self.currentGroup)"])
            }
        }
        inNotif = !inNotif
        updateNotifButton()
    }
    
    @IBAction func markAllAsReadButtonAction(_ sender: Any) {
        if news.count != readNews.count {
            for new in news {
                if let isRead = new.isRead, !isRead {
                    new.isRead = true
                    readNews.append(ReadNews(id : new.id!))
                }
            }
            NSCodingData().saveReadNews(readNews: readNews)
            tableView.reloadData()
            NSCodingData().saveLastAllReadDate(date: Date(), group: currentGroup)
        }
        
//        updateMarkAllAsReadButton()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if news.count == 0 || news.count % 25 != 0 {
            return news.count
        }
        else {
            return news.count + 1
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= self.news.count {
            return
        }
        let index = news[indexPath.row]
        readNews.append(ReadNews(id : index.id!))
        index.isRead = true
        let cell = tableView.cellForRow(at: indexPath) as! NewsCell
        cell.configureIsRead()
        NSCodingData().saveReadNews(readNews: readNews)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row >= self.news.count && !self.news.isEmpty && self.news.count % 25 == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingCell", for: indexPath) as! LoadingCell
            cell.activityIndicator.startAnimating()
            getNewsWithDate(date: news[self.news.count - 1].creation_date!)
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell

        let index = news[indexPath.row]
        
        let subjectSetup = setupSubject(index.subject!)
        
        if let allReadDate = getLastAllReadDate(), let newsDate = index.creation_date, allReadDate > StrToDate(dateStr: newsDate) {
            readNews.append(ReadNews(id : index.id!))
            index.isRead = true
        }
        
        cell.tags = subjectSetup.0
        cell.configure(index)
        cell.subjectLabel.text = subjectSetup.1

        return cell
    }

    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTopic" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!
            let destination = segue.destination as! TopicTVC
            destination.idNews = news[(indexPath.row)].id!
            destination.nb_msg = news[(indexPath.row)].msg_nb!
            if title == "assistants.news" || !(UserDefaults.standard.bool(forKey: "CNEnabled")) {
                destination.isNetiquetteCheckerActivated = false
            }
        }
    }
}

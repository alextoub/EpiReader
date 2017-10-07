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

class NewsTVC: UITableViewController {

    // MARK: - Global variables

    @IBOutlet weak var notificationButton: UIBarButtonItem!

    var news = [News]()
    var currentGroup = ""
    var readNews = [ReadNews]()
    var tags = [Tag]()
    var favorites = [Favorite]()
    var bannerView: GADBannerView!
    var inNotif = false

    // MARK: - View LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = currentGroup

        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Chargement en cours")

        setupNews()
        inNotif = checkInNotifs(name: currentGroup)
        updateNotifButton()
        
        self.tableView.es_addPullToRefresh {
            self.setupNews()
            self.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }

        initBannerView()
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
                }
                else
                {
                    SVProgressHUD.showError(withStatus: "Une erreur s'est produite")
                    SVProgressHUD.dismiss(withDelay: 0.5)
                }
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

    // MARK: - Custom methods

    func setupNews() {
        getNews()
        getReadNews()
        getTags()
        tableView.reloadData()
    }
    
    func initBannerView() {
        
        //TODO: Add way to hide if no connection
        //TODO: Add boolean isPremium -> No ads
        
        navigationController?.isToolbarHidden = false
        bannerView = GADBannerView()
        bannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 44))
        bannerView.adUnitID = Constants.AdMob.unitID
        
        bannerView.rootViewController = self
        bannerView.frame = CGRect(x: (UIScreen.main.bounds.width - bannerView.frame.width) / 2,
                                  y: 0.0,
                                  width: bannerView.frame.size.width,
                                  height: bannerView.frame.size.height)
        navigationController?.toolbar.addSubview(bannerView)
        let request = GADRequest()
        bannerView.load(request)
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
    
    //TODO: Delete this function, replace by collectionView
    func parseSub(_ subject: String) -> NSMutableAttributedString {
        let str = NSMutableAttributedString()
        let parsedSubject = parseSubject(subject)
        var i = 0
        let cnt = parsedSubject.count
        for sub in parsedSubject {
            if i != cnt - 1 && sub != "Re: " && sub != "Re:" {
                let tag = check(tag: sub, in: tags)

                if !tag.1 {
                    addToTags(tag: tag.0)
                }

                var new = NSMutableAttributedString(string: sub,
                                                    attributes: [NSAttributedStringKey.backgroundColor: tag.0.attributedColor!,
                                                                 NSAttributedStringKey.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
                str.append(new)
                new = NSMutableAttributedString(string: " ")
                str.append(new)
            }
            else {
                let new = NSMutableAttributedString(string: sub)
                str.append(new)
            }
            i += 1
        }
        return str
    }
    
    // MARK: - NSCoding Data

    func getReadNews() {
        readNews.removeAll()
        if let readNew = NSCodingData().loadReadNews() {
            readNews += readNew
        }
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
            }
        }
        else {
            MainBusiness.postSubscribeNotification(service: "ios", registration_id: StaticData.deviceToken, host: "news.epita.fr", newsgroup: currentGroup) { (response, error) in
                DispatchQueue.main.async {
                    if error == nil {
                        if let index = StaticData.notificationsGroups.index(of: self.currentGroup) {
                            StaticData.notificationsGroups.remove(at: index)
                        }
                    }
                }
            }
        }
        inNotif = !inNotif
        updateNotifButton()
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
        let cell = tableView.cellForRow(at: indexPath) as! NewsCell
        cell.readIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        if cell.msgNbIndicator.image == #imageLiteral(resourceName: "double_arrow_green") {
            cell.msgNbIndicator.image = #imageLiteral(resourceName: "double_arrow_grey")
        }
        else {
            cell.msgNbIndicator.image = #imageLiteral(resourceName: "single_arrow")
        }
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
        cell.configure(index)
        cell.subjectLabel.attributedText = parseSub(index.subject!)
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
            if title == "assistants.news" {
                destination.isNetiquetteCheckerActivated = false
            }
        }
    }
}

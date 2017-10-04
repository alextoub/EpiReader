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

        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show(withStatus: "Chargement en cours")

        setupNews()
        inNotif = checkInNotifs(name: currentGroup)
        updateNotifButton()
        self.title = currentGroup
        self.tableView.es_addPullToRefresh {
            self.setupNews()
            self.tableView.es_stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
        }

        bannerView = GADBannerView()
        bannerView.adSize =  GADAdSizeFromCGSize(CGSize(width: 320, height: 60))
        bannerView.adUnitID = Constants.AdMob.unitID

        let offset  = UIApplication.shared.statusBarFrame.height + (self.navigationController?.navigationBar.bounds.height)! + bannerView.frame.height


        bannerView.rootViewController = self
        bannerView.frame = CGRect(x:0.0,
                                  y:UIScreen.main.bounds.height - offset,
                                  width:bannerView.frame.size.width,
                                  height:bannerView.frame.size.height)
        let request = GADRequest()
        bannerView.load(request)
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

    // MARK: - Custom functions

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

    func checkTag(_ tag: String) -> Tag {
        var b = false
        var tagged: Tag?
        for i in tags {
            if i.tagName == tag {
                b = true
                tagged = i
            }
        }
        if b == false {
            let color = getRandomColor()
            let new = Tag(tagName: tag, attributedColor: color)
            tags.append(new)
            NSCodingData().saveTag(tags: tags)
            tagged = new
        }
        return tagged!
    }

    func parseSub(_ subject: String) -> NSMutableAttributedString {
        let str = NSMutableAttributedString()
        let parsedSubject = parseSubject(subject)
        var i = 0
        let cnt = parsedSubject.count
        for sub in parsedSubject {
            if i != cnt - 1 && sub != "Re: " && sub != "Re:" {
                let tag = checkTag(sub)
                var new = NSMutableAttributedString(string: sub,
                                                    attributes: [NSBackgroundColorAttributeName: tag.attributedColor!,
                                                                 NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)])
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

//    func getRandomColor() -> UIColor {
//        let randomRed = Int(arc4random_uniform(UInt32(255)))
//        let randomGreen = Int(arc4random_uniform(UInt32(255)))
//        let randomBlue = Int(arc4random_uniform(UInt32(255)))
//        let color = UIColor(red: CGFloat(CGFloat(randomRed)/255.0),
//                            green: CGFloat(CGFloat(randomGreen)/255.0),
//                            blue: CGFloat(CGFloat(randomBlue)/255.0), alpha: 1.0)
//        return color
//    }

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

    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return bannerView
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 60
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
        let authorArr = parseAuthor(index.author!)
        cell.authorLabel.text = authorArr[0]
        cell.mailLabel.text = authorArr[1]
        cell.readIndicator.layer.masksToBounds = true
        cell.readIndicator.layer.cornerRadius = cell.readIndicator.bounds.height / 2
        cell.dateLabel.text = StrToAbrev(dateStr: index.creation_date!)
        cell.subjectLabel.attributedText = parseSub(index.subject!)
        if index.msg_nb! > 1 {
            cell.msgNbIndicator.image = #imageLiteral(resourceName: "double_arrow_green")
        }
        else {
            cell.msgNbIndicator.image = #imageLiteral(resourceName: "single_arrow")
        }
        if index.isRead != nil && index.isRead! {
            cell.readIndicator.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            if cell.msgNbIndicator.image == #imageLiteral(resourceName: "double_arrow_green"){
                cell.msgNbIndicator.image = #imageLiteral(resourceName: "double_arrow_grey")
            }
        }
        else {
            cell.readIndicator.backgroundColor = #colorLiteral(red: 0.3430494666, green: 0.8636034131, blue: 0.467017293, alpha: 1)
        }

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

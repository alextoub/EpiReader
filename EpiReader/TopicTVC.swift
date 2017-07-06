//
//  TopicTVC.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import SVProgressHUD
import AlamofireImage

class TopicTVC: UITableViewController {
  
  // MARK: - Global variables
  
  var nb_msg = 1
  var idNews: Int?
  var topic: Topic?
  var current: Topic?
  var index = 0
  var sizeCells = [CGFloat]()
  var topics = [Topic]()
  
  // MARK: - View LifeCycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupTopic()
    tableView.rowHeight = UITableViewAutomaticDimension
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  // MARK: - Call functions
  
  func createArrayOfTopics()
  {
    var curr = topic
    for _ in 0..<nb_msg {
      let topicTmp = Topic(id: curr?.id, uid: curr?.uid, author: curr?.author, subject: curr?.subject, content: curr?.content, creation_date: curr?.creation_date, groups: curr?.groups)
      topics.append(topicTmp)
      if (curr?.children?.count)! > 0 {
        curr = curr?.children?[0]
      }
    }
  }
  
  func getTopic(){
    MainBusiness.getTopics(id: idNews!) { (response, error) in
      DispatchQueue.main.async {
        if error == nil {
          self.topic = response
          self.current = self.topic
          self.createArrayOfTopics()
          self.index = 0
          self.setupSizeCells()
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
  
  // MARK: - Custom functions
  
  func setupSizeCells() {
    var i = 0
    sizeCells.removeAll()
    if nb_msg == 0 {
      sizeCells.append(195.0)
    }
    while i < nb_msg {
      sizeCells.append(195.0)
      i += 1
    }
  }
  
  func setupTopic() {
    getTopic()
    SVProgressHUD.setDefaultMaskType(.black)
    SVProgressHUD.show(withStatus: "Chargement en cours")
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if nb_msg == 0 {
      return 1
    }
    else {
      return nb_msg
    }
  }
  
  @IBAction func shareButtonAction(_ sender: Any) {
    let vc = UIActivityViewController(activityItems: [current?.subject, current?.author, current?.content], applicationActivities: nil)
    self.present(vc, animated: true, completion: nil)
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "TopicCell", for: indexPath) as! TopicCell
    guard (topics.count > 0) else {
      return cell
    }
    let index = topics[indexPath.row]
    print(cell.bounds.height)
    
    cell.authorLabel.text = parseAuthor((index.author)!)[0]
    cell.contentText.text = index.content
    cell.subjectLabel.text = index.subject
    cell.dateLabel.text = StrToAbrevWithHour(dateStr: (index.creation_date)!)
    let url = URL(string: "https://photos.cri.epita.net/" + parseLogin(parseAuthor((index.author)!)[1]) + "-thumb")
    cell.photoImageView.af_setImage(withURL: url!, placeholderImage: #imageLiteral(resourceName: "default_picture"))

    if (parseAuthor((index.author)!)[1] == "chefs@yaka.epita.fr") {
      cell.photoImageView.image = #imageLiteral(resourceName: "chefs")
    }
    
    if cell.photoImageView.image == nil {
      print("oui c nil")
    }
    
    cell.displayCell()
    if sizeCells[indexPath.row] == 195.0 {
      var newContentText = cell.contentText.frame
      newContentText.size.width = cell.contentText.contentSize.width
      newContentText.size.height = cell.contentText.contentSize.height
      cell.contentText.frame = newContentText
      sizeCells[indexPath.row] = cell.contentText.contentSize.height
    }
    cell.contentText.sizeThatFits(CGSize(width: cell.contentText.contentSize.width, height: cell.contentText.contentSize.height))
    cell.contentText.isScrollEnabled = false
    return cell
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    guard (sizeCells.count > 0) else {
      return 195
    }
    print(195 - 128 + sizeCells[indexPath.row])
    return 195 - 128 + sizeCells[indexPath.row]
    //return 3000
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showImage" {
      let viewPos : CGPoint = (sender as AnyObject).convert(CGPoint.zero , to: self.tableView)
      let indexPath = self.tableView.indexPathForRow(at: viewPos)
      let vc = segue.destination as! ImageVC
      let cell = tableView.cellForRow(at: indexPath!) as! TopicCell
      vc.image = cell.photoImageView.image!
    }
  }
  
}

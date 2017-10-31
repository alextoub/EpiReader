//
//  StoryCell.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 30/10/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

class StoryCell: UITableViewCell {//, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var stories = [Story]()
    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 25 //stories.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCollectionCell", for: indexPath) as! StoryCVCell
//
//        cell.userImageView.image = #imageLiteral(resourceName: "default_picture")
//        cell.newsgroupLabel.text = "newsgroup"
//        cell.userLabel.text = "user"
//
//
//        return cell
//
//    }
    
    
    //@IBOutlet weak var storyCollectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.storyCollectionView!.register(StoryCVCell.self, forCellWithReuseIdentifier: "StoryCollectionCell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

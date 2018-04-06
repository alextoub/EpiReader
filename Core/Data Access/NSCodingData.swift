//
//  NSCodingData.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 23/09/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import Foundation

class NSCodingData {
    public func saveFavorites(favorites: [Favorite]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(favorites, toFile: Favorite.ArchiveURL.path)
        if isSuccessfulSave {
            print("Favorites successfully saved.")
        } else {
            print("Failed to save favorites...")
        }
    }
    
    public func loadFavorites() -> [Favorite]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: Favorite.ArchiveURL.path) as? [Favorite]
    }
    
    public func saveReadNews(readNews: [ReadNews]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(readNews, toFile: ReadNews.ArchiveURL.path)
        if isSuccessfulSave {
            print("ReadNews successfully saved.")
        } else {
            print("Failed to save readNews...")
        }
    }
    
    public func loadReadNews() -> [ReadNews]?  {
        return NSKeyedUnarchiver.unarchiveObject(withFile: ReadNews.ArchiveURL.path) as? [ReadNews]
    }
    
    public func saveLastAllReadDate(date: Date, group: String) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(date, toFile: FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("lastAllReadDate\(group)").path)
        if isSuccessfulSave {
            print("LastAllReadDate successfully saved.")
        } else {
            print("Failed to save LastAllReadDate...")
        }
    }
    
    public func loadLastAllReadDate(group: String) -> Date? {
        return NSKeyedUnarchiver.unarchiveObject(withFile: FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!.appendingPathComponent("lastAllReadDate\(group)").path) as? Date
    }
    
    public func saveTag(tags: [Tag]) {
        let isSuccessfulSave = NSKeyedArchiver.archiveRootObject(tags, toFile: Tag.ArchiveURL.path)
        if isSuccessfulSave {
            print("Tag successfully saved.")
        } else {
            print("Failed to save tag...")
        }
    }
    
    public func deleteTagFile() {
        if FileManager.default.fileExists(atPath: Tag.ArchiveURL.path) {
            do {
                try FileManager.default.removeItem(at: Tag.ArchiveURL)
            } catch {
                print(error)
            }
        }
    }
    
    public func loadTag() -> [Tag]?  {
        print(Tag.ArchiveURL.path)
        return NSKeyedUnarchiver.unarchiveObject(withFile: Tag.ArchiveURL.path) as? [Tag]
    }
}

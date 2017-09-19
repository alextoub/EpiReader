//
//  AppDelegate.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?
  
  var favorites = [Favorite]()
  
  private func loadFavorites() -> [Favorite]?  {
    return NSKeyedUnarchiver.unarchiveObject(withFile: Favorite.ArchiveURL.path) as? [Favorite]
  }

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    favorites.removeAll()
    if let fav = loadFavorites() {
      favorites += fav
    }
    
    UIApplication.shared.shortcutItems?.removeAll()
    
    if favorites.count > 0 {
      let fav1 = UIApplicationShortcutItem(type: Bundle.main.bundleIdentifier! + ".Fav1", localizedTitle: (favorites[0].group_name)!, localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .favorite), userInfo: nil)
      UIApplication.shared.shortcutItems?.append(fav1)
      if favorites.count > 1 {
        let fav2 = UIApplicationShortcutItem(type: Bundle.main.bundleIdentifier! + ".Fav2", localizedTitle: (favorites[1].group_name)!, localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .favorite), userInfo: nil)
        UIApplication.shared.shortcutItems?.append(fav2)
        if favorites.count > 2 {
          let fav3 = UIApplicationShortcutItem(type: Bundle.main.bundleIdentifier! + ".Fav3", localizedTitle: (favorites[2].group_name)!, localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .favorite), userInfo: nil)
          UIApplication.shared.shortcutItems?.append(fav3)
        }
      }
    }
    
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
  /**
   Called when a 3D touch shortcut is triggered
   
   - parameter application: the current application
   - parameter performActionFor: the shortcut object triggered
   - parameter completionHandler: @escaping allow the user to perform any kind of action
   */
  @available(iOS 9.0, *)
  func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
    let handledShortCutItem = handleShortCutItem(shortcutItem: shortcutItem)
    completionHandler(handledShortCutItem)
  }
  
  /**
   Handle shortcut actions
   
   - parameter shortcutItem: the shortcut triggered
   
   - returns: true if shortcut action was performed successfully
   */
  @available(iOS 9.0, *)
  func handleShortCutItem(shortcutItem: UIApplicationShortcutItem) -> Bool {
    var handled = false
    let storyboard = UIStoryboard(name: "Main", bundle: nil)
    let nav = storyboard.instantiateViewController(withIdentifier: "MainNav") as! UINavigationController
    let vc1 = storyboard.instantiateViewController(withIdentifier: "MainTVC") as! MainTVC
    let vc = storyboard.instantiateViewController(withIdentifier: "NewsTVC") as! NewsTVC
    nav.pushViewController(vc1, animated: false)
    nav.pushViewController(vc, animated: false)
    
    if shortcutItem.type == Bundle.main.bundleIdentifier! + ".Fav1" && favorites.count > 0 {
      vc.currentGroup = favorites[0].group_name!
      self.window?.rootViewController = nav
      self.window?.makeKeyAndVisible()
      handled = true
    }
    else if shortcutItem.type == Bundle.main.bundleIdentifier! + ".Fav2" && favorites.count > 1 {
      vc.currentGroup = favorites[1].group_name!
      self.window?.rootViewController = nav
      self.window?.makeKeyAndVisible()
      handled = true
      
    }
    else if shortcutItem.type == Bundle.main.bundleIdentifier! + ".Fav3" && favorites.count > 2 {
      vc.currentGroup = favorites[2].group_name!
      self.window?.rootViewController = nav
      self.window?.makeKeyAndVisible()
      handled = true
    }
    return handled
  }


}


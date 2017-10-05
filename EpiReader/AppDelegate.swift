//
//  AppDelegate.swift
//  EpiReader
//
//  Created by Alexandre Toubiana on 20/03/2017.
//  Copyright © 2017 Alexandre Toubiana. All rights reserved.
//

import UIKit
import Fabric
import Crashlytics
import Alamofire
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func initializeApp() {
        RequestService().getGroups()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Fabric.with([Crashlytics.self])
        registerForPushNotifications()
        initializeApp()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
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
        UIApplication.shared.applicationIconBadgeNumber = 0
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        if application.applicationState == .background || application.applicationState == .inactive {
            
            let aps = userInfo["aps"] as! [String: AnyObject]
            let alert = aps["alert"] as! [String: AnyObject]
            let title = alert["subtitle"] as? String
            
            let news_id = aps["news_id"] as? Int
            
            if title != nil && news_id != nil {
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                let nav = storyBoard.instantiateViewController(withIdentifier: "NavigationVC") as! UINavigationController
                
                let firstView: MainTVC = storyBoard.instantiateViewController(withIdentifier: "MainTVC") as! MainTVC
                
                let secondView: NewsTVC = storyBoard.instantiateViewController(withIdentifier: "NewsTVC") as! NewsTVC
                secondView.currentGroup = title!
            
                let thirdView : TopicTVC = storyBoard.instantiateViewController(withIdentifier: "TopicTVC") as! TopicTVC
                thirdView.idNews = news_id
                thirdView.nb_msg = 1
                
                if title == "assistants.news" {
                    thirdView.isNetiquetteCheckerActivated = false
                }
            
                nav.pushViewController(firstView, animated: false)
                nav.pushViewController(secondView, animated: false)
                nav.pushViewController(thirdView, animated: false)
            
                var readNews = NSCodingData().loadReadNews()
                readNews?.append(ReadNews(id: news_id!))
                NSCodingData().saveReadNews(readNews: readNews!)
            
                self.window = UIWindow(frame: UIScreen.main.bounds)
                self.window?.rootViewController = nav
                self.window?.makeKeyAndVisible()
            }
            
        }
    }
    
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        StaticData.deviceToken = token
        RequestService().postSubscribedGroups()
        print("Device Token: \(token)")
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
}


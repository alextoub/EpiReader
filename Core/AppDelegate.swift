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
        Fabric.with([Crashlytics.self])
        registerForPushNotifications()
        initializeApp()
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
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
                
                let firstView: MainVC = storyBoard.instantiateViewController(withIdentifier: "MainVC") as! MainVC
                
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
            DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()
            })
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


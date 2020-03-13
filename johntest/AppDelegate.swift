//
//  AppDelegate.swift
//  johntest
//
//  Created by John Tan on 3/10/20.
//  Copyright © 2020 John Tan. All rights reserved.
//

import UIKit
import Branch

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //using the Test key
        Branch.setUseTestBranchKey(true)
        
        //listener for Branch deep link data
        
        Branch.getInstance().initSession(launchOptions: launchOptions) { (params,error)in
            //do stuff with deep link data (nav to page, display content, etc
            
            if error == nil {
                
                let clickedBranchLink = params?["+clicked_branch_link"] as? Bool == true
                let deepLinkPath = params?["$deeplink_path"] as? String
                let face = params?["face"] as? String
                let name = params?["name"] as? String
                let body = params?["body"] as? String
                let color = params?["color"] as? String
                
                if (clickedBranchLink){
                    if(deepLinkPath != nil){
                        if(face != nil){
                            DeeplinkNavigator.navigate(with: face ?? "")
                        } else if(name != nil) {
                            DeeplinkNavigator.navigate(with: name ?? "")
                        } else if(body != nil) {
                            DeeplinkNavigator.navigate(with: body ?? "")
                        } else if(color != nil) {
                            DeeplinkNavigator.navigate(with: color ?? "")
                        }
                     }
                }
                
            }
            
        }
        
        Branch.getInstance().setDebug()
        
        // Override point for customization after application launch.
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options:[UIApplication.OpenURLOptionsKey: Any]=[:]) -> Bool {
        Branch.getInstance().application(app, open: url, options: options)
        return true
    }

    private func application(_ application: UIApplication, continue userActivity:NSUserActivity, restorationHandler: @escaping([Any]?) -> Void) -> Bool {
        //handler for universal links
        Branch.getInstance().continue(userActivity)
        return true
    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
//        //handler for push notifications
//        Branch.getInstance().handlePushNotification(userInfo)
//
//    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    


}


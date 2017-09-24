//
//  AppDelegate.swift
//  Chat
//
//  Created by Air on 20.09.17.
//  Copyright © 2017 Dasha. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var previousState = -1

    let states: Dictionary<Int, String> = [
        -1: "Not running",
        UIApplicationState.active.rawValue: "Active",
        UIApplicationState.inactive.rawValue: "Inactive",
        UIApplicationState.background.rawValue: "Background"
    ]
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        print("Application moved from \(states[previousState]!) to \(states[application.applicationState.rawValue]!): \(#function)")
        previousState = application.applicationState.rawValue
        
//        window = UIWindow.init(frame: UIScreen.main.bounds)
//        if let keyWindow = window {
//            keyWindow.rootViewController = ProfileViewController()
//            keyWindow.makeKeyAndVisible()
//        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {

        
        print("Application moved from \(states[previousState]!) to \(states[1]!): \(#function)")
        previousState = 1
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        print("Application moved from \(states[previousState]!) to \(states[application.applicationState.rawValue]!): \(#function)")
        previousState = application.applicationState.rawValue
        
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
        print("Application moved from \(states[previousState]!) to \(states[1]!): \(#function)")
        previousState = 1
        
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
        print("Application moved from \(states[previousState]!) to \(states[application.applicationState.rawValue]!): \(#function)")
        previousState = application.applicationState.rawValue

        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        print("Application moved from \(states[previousState]!) to \(states[-1]!): \(#function)")
        previousState = -1
        
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}


//
//  AppDelegate.swift
//  YouTubeEx
//
//  Created by user140592 on 1/3/19.
//  Copyright © 2019 talspektor. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let laytout = UICollectionViewFlowLayout()
//        laytout.scrollDirection = .horizontal
        let navigationController = UINavigationController(rootViewController: HomeController(collectionViewLayout: laytout))
        window?.rootViewController = navigationController
        
        navigationController.navigationBar.tintColor = .white
        navigationController.navigationBar.barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationController.navigationBar.isTranslucent = false
        
        // get rid of black bar underneath navbar
        UINavigationBar.appearance().shadowImage = UIImage()//Remove bar shadow
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        
        UIApplication.shared.statusBarStyle = .lightContent
        let statusBar : UIView = UIApplication.shared.value(forKey: "statusBar") as! UIView
        statusBar.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
        
    
    
        window?.addSubview(statusBar)
        statusBar.leadingAnchor.constraint(equalTo: (window?.leadingAnchor)! ).isActive = true
        statusBar.trailingAnchor.constraint(equalTo: (window?.trailingAnchor)!).isActive = true
        statusBar.topAnchor.constraint(equalTo: (window?.topAnchor)!).isActive = true
        statusBar.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
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


}


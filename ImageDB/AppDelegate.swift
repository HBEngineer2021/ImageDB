//
//  AppDelegate.swift
//  ImageDB
//
//  Created by Motoki Onayama on 2021/06/09.
//

import UIKit
import FMDB

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

   func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       // Override point for customization after application launch.
       Util.share.copyDatabase(dbName: "dbName.db")
       dbMethod()
       return true
   }

   func dbMethod() {
       let database = FMDatabase(url: fileURL)
       
       guard database.open() else {
           print("Unable to open database")
           return
       }
       do {
           try database.executeUpdate("CREATE TABLE IF NOT EXISTS ImageMD(id INTEGER PRIMARY KEY AUTOINCREMENT, image BLOB)", values: nil)
       }
       catch {
           print("\(error.localizedDescription)")
       }
       database.close()
   }
   
   
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

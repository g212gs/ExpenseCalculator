//
//  AppDelegate.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 07/04/25.
//

import UIKit
import FirebaseCore
import FirebaseAuth

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Pass device token to auth
        debugPrint("deviceToken: \(deviceToken)")
        Auth.auth().setAPNSToken(deviceToken, type: .sandbox)
    }
    
    func application(_ application: UIApplication,
                     didReceiveRemoteNotification notification: [AnyHashable : Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        debugPrint("didReceiveRemoteNotification \(notification)")
        if Auth.auth().canHandleNotification(notification) {
            completionHandler(.noData)
            return
        }
        // This notification is not auth related; it should be handled separately.
        debugPrint("canHandleNotification false")
    }
    
    func application(_ application: UIApplication, open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        if Auth.auth().canHandle(url) {
            return true
        }
        // URL not auth related; it should be handled separately.
        return true
    }
}

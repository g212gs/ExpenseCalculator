//
//  AppMainRouter.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI

@Observable
class AppMainRouter {
    
    var navigationPath = NavigationPath()
    static var arrNavigationpath: [AppMainNavigationPath] = [] // we will store the nath in this as well
    
    func pushToScreen(route: AppMainNavigationPath) {
        debugPrint("push to screen: \(route.name)")
        // Check if path already present in stack then pop to that path
        if AppMainRouter.arrNavigationpath.contains(where: { $0.name == route.name }) {
            debugPrint("screen name: \(route.name) already present in stack - so going to pop to this screen")
            popToScreen(route: route)
            return
        }
        
        // add path in stack and push to screen
        navigationPath.append(route)
        AppMainRouter.arrNavigationpath.append(route)
        
        debugPrint("[Navigation stack]: \(AppMainRouter.arrNavigationpath.map { $0.name })")
    }
    
    func popToScreen(route: AppMainNavigationPath) {
        debugPrint("poptosceeen to route: \(route.name) - navPathCount: \(navigationPath.count) - route index: \(route.index)")
        
        // Check if path already present in stack then pop to that path
        if AppMainRouter.arrNavigationpath.contains(where: { $0.name == route.name }) {
            let count = navigationPath.count - route.index
            debugPrint("[Navigation stack]: count to remove: \(count) from arrCount: \(navigationPath.count)")
            if count >= 0 {
                navigationPath.removeLast(count)
                AppMainRouter.arrNavigationpath.removeLast(count)
                debugPrint("[Navigation stack]: \(AppMainRouter.arrNavigationpath.map { $0.name })")
            } else {
                debugPrint("[Navigation stack]: could not go back to previous screen")
            }
            return
        }
        
        navigationPath.append(route)
        AppMainRouter.arrNavigationpath.append(route)
        debugPrint("[Navigation stack]: \(AppMainRouter.arrNavigationpath.map { $0.name })")
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
        AppMainRouter.arrNavigationpath = []
        debugPrint("[Navigation stack]: \(AppMainRouter.arrNavigationpath.map { $0.name })")
    }
    
    func popToLoginScreen() {
        navigationPath.removeLast(navigationPath.count)
        navigationPath.append(AppMainNavigationPath.login)
        AppMainRouter.arrNavigationpath = [AppMainNavigationPath.login]
        debugPrint("[Navigation stack]: \(AppMainRouter.arrNavigationpath.map { $0.name })")
    }
    
}

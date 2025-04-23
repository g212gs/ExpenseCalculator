//
//  AppMainRouter.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI

@Observable
class AppMainRouter {
    
    var navigationPath: [AppMainNavigationPath] =  []
    
    func pushToScreen(route: AppMainNavigationPath) {
        navigationPath.append(route)
    }
    
    func popToScreen(route: AppMainNavigationPath) {
        
        if let index = navigationPath.firstIndex(of: route) {
            navigationPath.removeLast(navigationPath.count - (index + 1))
        }
    }
    
    func popToRoot() {
        navigationPath.removeLast(navigationPath.count)
    }
    
    func popToLoginScreen() {
        navigationPath.removeLast(navigationPath.count)
        navigationPath.append(AppMainNavigationPath.login)
    }
    
}

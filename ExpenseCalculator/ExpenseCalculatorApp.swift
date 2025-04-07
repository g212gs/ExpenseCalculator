//
//  ExpenseCalculatorApp.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI

@main
struct ExpenseCalculatorApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AppMainCoordinator()
        }
    }
}


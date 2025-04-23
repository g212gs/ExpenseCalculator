//
//  AppMainCoordinator.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI

struct AppMainCoordinator: View {
    
    @State private var router = AppMainRouter()
    
    var body: some View {
        
        NavigationStack(path: $router.navigationPath) {
            SplashScreen()
                .environment(router)
                .navigationDestination(for: AppMainNavigationPath.self) { route in
                    switch route {
                    case .login:
                        LoginScreen()
                    case .verifyOtp(let phoneNumber, let verificationID):
                        VerifyOTPScreen(phoneNumber: phoneNumber, verificationID: verificationID)
                    case .home:
                        HomeScreen()
                    case .setting:
                        SettingScreen()
                    case .accountSetting:
                        AccountSettingScreen()
                    case .expenseDetail:
                        EmptyView()
                    case .expenseList:
                        EmptyView()
                    case .addExpense:
                        AddExpenseScreen()
                    }
                }
        }
        .environment(router)
    }
}

#Preview {
    AppMainCoordinator()
}

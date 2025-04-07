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
//                    let _ = debugPrint("[Navigation stack]: navigationDestination change to route : \(route.name)")
                    switch route {
                    case .login:
                        LoginScreen()
                            .environment(router)
                    case .verifyOtp(let phoneNumber, let verificationID):
                        VerifyOTPScreen(phoneNumber: phoneNumber, verificationID: verificationID)
                            .environment(router)
                    case .home:
                        HomeScreen()
                            .environment(router)
                    case .setting:
                        SettingScreen()
                            .environment(router)
                    case .accountSetting:
                        AccountSettingScreen()
                            .environment(router)
                    case .expenseDetail:
                        EmptyView()
                    case .expenseList:
                        EmptyView()
                    }
                }
        }
        .onChange(of: router.navigationPath) { oldValue, newValue in
            // This is for handling default back button and swipe to back
            if oldValue.count > newValue.count {
                let countToPop = oldValue.count - newValue.count
                if countToPop == 1 {
                    AppMainRouter.arrNavigationpath.removeLast()
                }
            }
        }
    }
}

#Preview {
    AppMainCoordinator()
}

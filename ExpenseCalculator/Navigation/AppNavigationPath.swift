//
//  AppMainNavigationPath.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import Foundation

enum AppMainNavigationPath {
    case login
    case verifyOtp(phoneNumber: String, verificationID: String)
    case home
    case setting
    case accountSetting
    case expenseList
    case expenseDetail
    case addExpense
}

extension AppMainNavigationPath {
    
    var name: String {
        switch self {
        case .verifyOtp(_, _):
            return "verifyOtp"
        default:
            return String(describing: self)
        }
    }
    
//    // This will be dynamic based on different flow - and calculate based on requirement. - only useful for popToScreen
//    var index: Int {
//        switch self {
//        case .login:
//            return 1
//        case .verifyOtp(_ , _):
//            return 2
//        case .home:
//            return 1
//        case .setting:
//            return 2
//        case .accountSetting:
//            return 3
//        case .expenseList:
//            return 2
//        case .expenseDetail:
//            return 3
//        case .addExpense:
//            return 2
//        }
//    }
}

extension AppMainNavigationPath: Hashable { }

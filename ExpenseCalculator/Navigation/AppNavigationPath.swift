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

extension AppMainNavigationPath: Hashable { }

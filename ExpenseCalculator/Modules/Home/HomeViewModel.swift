//
//  HomeViewModel.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 12/04/25.
//

import Foundation
import Combine

class HomeViewModel: ObservableObject {
    
    var navigationCancellable = Set<AnyCancellable>()
    let navigationPublisher = PassthroughSubject<AppMainNavigationPath, Never>()
    
    @Published var expenseList: [Expense] = []
    
    func isExpenseAvailable() -> Bool {
        return (expenseList.count > 0)
    }
    
    func addExpense() {
        navigationPublisher.send(AppMainNavigationPath.expenseDetail)
    }
    
    func settingTapped() {
        navigationPublisher.send(AppMainNavigationPath.setting)
    }
    
    func cancelSubs() {
        _ = self.navigationCancellable.map { $0.cancel() }
    }
    
}

//
//  AddExpenseViewModel.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 12/04/25.
//

import Foundation

class AddExpenseViewModel: ObservableObject {
    
    @Published var expenseAmt: Decimal = 0
    var expenseList: [Expense] = Expense.dummyList
    
    func addExpense(withIndex index: Int) {
        debugPrint("Add expense name: \(expenseList[index].name) - amount: \(expenseAmt)")
    }
    
    func resetExpenseAmount() {
        self.expenseAmt = 0
    }
    
}

//
//  ExpenseModel.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 13/04/25.
//

import Foundation
import SwiftData

@Model
class ExpenseModel: Identifiable {
    var id: String
    var name: String
    var amount: Double
    var imageName: String
    
    init(name: String, amount: Double, imageName: String) {
        self.id = UUID().uuidString
        self.name = name
        self.amount = amount
        self.imageName = imageName
    }
}

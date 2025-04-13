//
//  Expense.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 12/04/25.
//

import UIKit

struct Expense: Codable, Hashable, Equatable {
    
    static func == (lhs: Expense, rhs: Expense) -> Bool {
        lhs.id == rhs.id
    }
    

    var id = UUID()
    var name: String
    var icon: String
    
    init(name: String, icon: String) {
        self.name = name
        self.icon = icon
    }
}

extension Expense {
    
    static var dummyList: [Expense] {
        var list: [Expense] = []
        
        let fruitApple = Expense(name: "Apple", icon: "fruit_apple")
        let fruitAvocado = Expense(name: "Avocado", icon: "fruit_avocado")
        let fruitBanana = Expense(name: "Banana", icon: "fruit_banana")
        let fruitGrapes = Expense(name: "Grapes", icon: "fruit_grapes")
        let fruitKiwi = Expense(name: "Kiwi", icon: "fruit_kiwi")
        let fruitMango = Expense(name: "Mango", icon: "fruit_mango")
        let fruitPomogranate = Expense(name: "Pomogranate", icon: "fruit_pomogranate")
        let fruitSitafal = Expense(name: "Sitafal", icon: "fruit_sitafal")
        let fruitStrawberry = Expense(name: "Strawberry", icon: "fruit_strawberry")
        let fruitWaterMelon = Expense(name: "Water Melon", icon: "fruit_watermelon")
        let fruitguava = Expense(name: "Guava", icon: "fruit_guava")
        let fruitOrange = Expense(name: "Orange", icon: "fruit_orange")
        let fruitPapaya = Expense(name: "Papaya", icon: "fruit_papaya")
        let fruitPineapple = Expense(name: "Pineapple", icon: "fruit_pineapple")
        let fruitChikoo = Expense(name: "Chikoo", icon: "fruit_chikoo")
        let fruitMuskmelon = Expense(name: "Muskmelon", icon: "fruit_muskmelon")
        
        list = [fruitApple,
                fruitAvocado,
                fruitBanana,
                fruitGrapes,
                fruitKiwi,
                fruitMango,
                fruitPomogranate,
                fruitSitafal,
                fruitStrawberry,
                fruitWaterMelon,
                fruitguava,
                fruitOrange,
                fruitPapaya,
                fruitPineapple,
                fruitChikoo,
                fruitMuskmelon
        ]
        
        return list
    }
}

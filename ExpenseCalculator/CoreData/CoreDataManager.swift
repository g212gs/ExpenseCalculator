//
//  CoreDataManager.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 19/04/25.
//

import Foundation
import CoreData

struct CoreDataManager {
    
    static let shared = CoreDataManager()
    let container: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ExpenseDataModel")
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { persistentStoreDescription, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            } else {
                debugPrint("loadPersistentStores successfully")
                debugPrint("Coredata path:  \(persistentStoreDescription.url?.path ?? "No URL found")")
                // /Users/gaurang/Library/Developer/CoreSimulator/Devices/E39E00EE-E6AC-44F2-A1F6-D557E3648A39/data/Containers/Data/Application/AABCE7A0-B144-42A4-94EF-C2DB9A50DAA5/Library/Application Support/ExpenseDataModel.sqlite"
            }
        }
    }
}

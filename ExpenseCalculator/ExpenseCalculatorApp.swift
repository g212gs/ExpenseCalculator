//
//  ExpenseCalculatorApp.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI
//import SwiftData

@main
struct ExpenseCalculatorApp: App {
    // register app delegate for Firebase setup
      @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate

    var body: some Scene {
        WindowGroup {
            AppMainCoordinator()
        }
        // For SwiftData
//        .modelContainer(for: ExpenseModel.self) { result in
//           switch result {
//           case .success(let container):
//               if let path = container.configurations.first?.url {
//                   debugPrint("SwiftData path: \(path)")
//                   // file:///Users/gaurang/Library/Developer/CoreSimulator/Devices/E39E00EE-E6AC-44F2-A1F6-D557E3648A39/data/Containers/Data/Application/02A0595D-7D23-4E0D-A5BA-9AB1BEF7FE8F/Library/Application%20Support/default.store
//               } else {
//                   debugPrint("SwithData path not found in configurations")
//               }
//           case .failure(let error):
//               fatalError("Unable to create SwiftDataModelContainer with error: \(error.localizedDescription)")
//           }
//        }
        // For CoreData
        .environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
    }
}


//
//  HomeScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI
import SwiftData
//import CoreData

struct HomeScreen: View {
    @Environment(AppMainRouter.self) var router
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State var showAddExpenseSheet: Bool = false
    
    // For SwiftData
//        @Environment(\.modelContext) private var modelContext
//        @Query private var items: [ExpenseModel]
    
    // For CoreData
    @Environment(\.managedObjectContext) private var managedObjectContext
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \ExpenseList.date, ascending: true)],
            animation: .default)
    private var items: FetchedResults<ExpenseList>
    
    

    
    let heights = stride(from: 0.1, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }
    
    var body: some View {
        VStack {
            if items.isEmpty {
                EmptyExpenseListView(showAddExpenseSheet: $showAddExpenseSheet)
            } else {
                List {
                    ForEach(items) { items in
                        HStack {
                            Text(items.title ?? "")
                            
                            Spacer()
                            
                            Text(convertAmt(items.amount))
                        }
                    }
                    .onDelete { indexes in
                        for index in indexes {
                            delete(items[index])
                        }
                    }
                }
                
            }
        }
        .navigationTitle(
            Text("Home")
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                HStack {
                    if items.count > 0 {
                        Button(action: {
                            showAddExpenseSheet.toggle()
                        }) {
                            Image(systemName: "plus.circle")
                                .foregroundColor(.primaryTextColor)
                        }
                    }
                    
                    Button(action: {
                        debugPrint("Settings")
                        viewModel.settingTapped()
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primaryTextColor)
                    }
                }
            }
            ToolbarItem(placement: .bottomBar) {
                HStack {
                    Spacer()
                    Text("Total: \(getTotalAmount())")
                        .font(.headline)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            self.addNavigationSubscriber()
        }
        .sheet(isPresented: $showAddExpenseSheet, content: {
            AddExpenseScreen()
            //                    .presentationDetents([.medium])
                .presentationDetents([.medium, .large])
            //                    .presentationDetents([.fraction(0.3)])
            //                    .presentationDetents([.height(300.0)])
            //                    .presentationDetents(Set(heights))
                .presentationDragIndicator(.automatic)
        })
    }
    
    func addNavigationSubscriber() {
        viewModel.cancelSubs()
        
        viewModel.navigationPublisher.sink { path in
            router.pushToScreen(route: path)
        }
        .store(in: &viewModel.navigationCancellable)
    }
    
    // For SwiftData -> Model name ExpenseModel
//    func delete(_ item: ExpenseModel) {
//        modelContext.delete(item)
//    }
    // For CoreData -> Model name ExpenseList
    func delete(_ item: ExpenseList) {
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("Failed to delete: \(error)")
        }
    }
    
    func convertAmt(_ amount: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.locale = .current
        
        if let formattedAmount = formatter.string(from: NSNumber(value: amount)) {
            return formattedAmount
        } else {
            return "--"
        }
    }
    
    func getTotalAmount() -> String {
        let totalAmt =  items.reduce(0) { $0 + $1.amount }
        return convertAmt(totalAmt)
    }
}

#Preview {
    var router = AppMainRouter()
    HomeScreen()
        .environment(router)
}

struct EmptyExpenseListView: View {
    
    @Binding var showAddExpenseSheet: Bool
    
    var body: some View {
        Button {
            showAddExpenseSheet.toggle()
        } label: {
            VStack(alignment: .center, spacing: 10) {
                Image(systemName: "plus.circle")
                    .symbolRenderingMode(.multicolor)
                    .font(Font.system(size: 100, weight: .bold))
                    .foregroundColor(Color.secondaryColor)
                
                Text("Add Expense")
                    .foregroundColor(Color.primaryTextColor)
            }
        }
    }
}

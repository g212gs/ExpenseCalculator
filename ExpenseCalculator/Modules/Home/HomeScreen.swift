//
//  HomeScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(AppMainRouter.self) var router
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State var showAddExpenseSheet: Bool = false
        
    let heights = stride(from: 0.1, through: 1.0, by: 0.1).map { PresentationDetent.fraction($0) }
    
    var body: some View {
        VStack {
            if viewModel.isExpenseAvailable() {
                Text(viewModel.expenseList.first?.name ?? "N/A")
            } else {
                EmptyExpenseListView(showAddExpenseSheet: $showAddExpenseSheet)
            }
            
            
        }
        .navigationTitle(
            Text("Home")
        )
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button(action: {
                    debugPrint("Settings")
                    viewModel.settingTapped()
                }) {
                    Image(systemName: "gearshape")
                        .foregroundColor(.primaryTextColor)
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

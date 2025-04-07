//
//  SplashScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI

struct SplashScreen: View {
    @Environment(AppMainRouter.self) var router
    @StateObject var viewModel = SplashViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.primaryColor
                    .ignoresSafeArea()
                
                VStack {
                    if #available(iOS 18.0, *) {
                        Image(systemName: "widget.large.badge.plus")
                            .symbolEffect(.wiggle, options: .repeat(.continuous))
                            .symbolRenderingMode(.multicolor)
                            .font(Font.system(size: 100, weight: .bold))
                            .foregroundColor(Color.secondaryColor)
                        
                    } else {
                        Image(systemName: "widget.large.badge.plus")
                            .symbolEffect(.scale)
                            .symbolRenderingMode(.multicolor)
                            .font(Font.system(size: 100, weight: .bold))
                            .foregroundColor(Color.secondaryColor)
                    }
                    
                    
                    Text("Expense Calculator")
                        .foregroundStyle(Color.secondaryColor)
                        .font(Font.system(size: 30, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.top, 20)
                }
            }
            .onAppear {
                self.addNavigationSubscriber()
                self.viewModel.setInitialData()
            }
        }
    }
    
    func addNavigationSubscriber() {
        self.viewModel.cancelSubs()
        
        self.viewModel.navigationPublisher.sink { path in
            router.pushToScreen(route: path)
        }.store(in: &viewModel.navigationCancellable)
    }
}

#Preview {
    var router = AppMainRouter()
    SplashScreen()
        .environment(router)
}

//
//  AccountSettingScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 29/03/25.
//

import SwiftUI

struct AccountSettingScreen: View {
    @Environment(AppMainRouter.self) var router
    @StateObject var viewModel = AccountSettingViewModel()
    
    var body: some View {
//        NavigationView {
            VStack {
                Button {
                    viewModel.logout()
                } label: {
                    Text("Logout")
                        .foregroundColor(.primaryBtnTitleColor)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.primaryColor)
                        .cornerRadius(8)
                }
                
                // Error Message
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding(.top, 10)
                }
            }
//        }
        .onAppear() {
            self.addNavigationSubscriber()
        }
        .navigationTitle(Text("Account Setting"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
    }
    
    func addNavigationSubscriber() {
        self.viewModel.cancelSubs()
        
        self.viewModel.navigationPublisher.sink { _ in
            router.popToLoginScreen()
        }
        .store(in: &viewModel.navigationCancellable)
    }
}

#Preview {
    AccountSettingScreen()
}

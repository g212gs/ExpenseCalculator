//
//  AccountSettingViewModel.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 06/04/25.
//

import SwiftUI
import Combine
import FirebaseAuth

class AccountSettingViewModel: ObservableObject {
    
    var navigationCancellable = Set<AnyCancellable>()
    let navigationPublisher = PassthroughSubject<AppMainNavigationPath, Never>()
    
    @Published var errorMessage: String? = nil
    
    func logout() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.navigationPublisher.send(.login)
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            self.errorMessage = "Error signing out: \(signOutError.localizedDescription)"
        }
    }
    
    func cancelSubs() {
        _ = self.navigationCancellable.map { $0.cancel() }
    }
}

//
//  SplashViewModel.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import UIKit
import Combine
import FirebaseAuth

class SplashViewModel: ObservableObject {

    var navigationCancellable = Set<AnyCancellable>()
    let navigationPublisher = PassthroughSubject<AppMainNavigationPath, Never>()
    
    @Published var isLoading: Bool = false
    
    // As per structure
    func setInitialData() {
        self.isLoading = true
        guard Auth.auth().currentUser != nil else {
            debugPrint(#function, "No current user")
            self.isLoading = false
            self.navigationPublisher.send(.login)
            return
        }
        self.isLoading = false
        self.navigationPublisher.send(.home)
    }
    
    func cancelSubs() {
        _ = self.navigationCancellable.map { $0.cancel() }
    }
    
}

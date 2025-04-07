//
//  VerifyOTPViewModel.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 05/04/25.
//

import SwiftUI
import FirebaseAuth
import Combine

class VerifyOTPViewModel: ObservableObject {
    
    var navigationCancellable = Set<AnyCancellable>()
    let navigationPublisher = PassthroughSubject<AppMainNavigationPath, Never>()
    
    var phoneNumber: String = ""
    var verificationID: String = ""
    
    @Published var otp: String = "123456"
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    func configureDetails(withPhoneNumber phoneNumber: String, verificationID: String) {
        self.phoneNumber = phoneNumber
        self.verificationID = verificationID
    }
    
    func verifyOTP() {
        
        let credential = PhoneAuthProvider.provider().credential(
          withVerificationID: verificationID,
          verificationCode: otp
        )
        
        self.isLoading = true
        Auth.auth().signIn(with: credential) { authResult, error in
            self.isLoading = false
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            debugPrint("Authentication successful - with details: \(String(describing: authResult))")
//            AuthDataResult
            
            guard let user = authResult?.user else { return }
            debugPrint("User phone number: \(user.phoneNumber ?? "No phone number found")")
            
            self.navigationPublisher.send(.home)
        }
        
    }
    
    func cancelSubs() {
        _ = self.navigationCancellable.map { $0.cancel() }
    }
}

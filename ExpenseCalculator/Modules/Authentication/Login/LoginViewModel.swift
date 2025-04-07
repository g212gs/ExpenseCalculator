//
//  LoginViewModel.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 30/03/25.
//

import UIKit
import FirebaseAuth
import Combine

class LoginViewModel: ObservableObject {
    
    var navigationCancellable = Set<AnyCancellable>()
    let navigationPublisher = PassthroughSubject<AppMainNavigationPath, Never>()

    @Published var countryCode: String = "+91"
    @Published var phoneNumber: String = "1234567890"
    
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    
    let countryCodes = ["+1", "+91"] // we will implement more dynamically later

    func sendOTP() {
        self.isLoading = true
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(getFullPhoneNumber(), uiDelegate: nil) { verificationID, error in
                self.isLoading = false
                if let error = error {
                    debugPrint("Error while send OTP with error: \(error.localizedDescription)")
                    self.errorMessage = error.localizedDescription
                    return
                }
                debugPrint("Send SMS successfully with verificationID: \(verificationID ?? "")")
                
                guard let verificationID = verificationID else {
                    self.errorMessage = "Something went wrong! Please try again later."
                    return
                }
                
                self.navigationPublisher.send(.verifyOtp(phoneNumber: self.getFullPhoneNumber(), verificationID: verificationID))
            }
    }
    
    func getFullPhoneNumber() -> String {
        return countryCode + phoneNumber
    }
    
    
    func cancelSubs() {
        _ = self.navigationCancellable.map { $0.cancel() }
    }
}

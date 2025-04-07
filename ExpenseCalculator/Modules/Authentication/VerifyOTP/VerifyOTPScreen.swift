//
//  VerifyOTPScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 05/04/25.
//

import SwiftUI

struct VerifyOTPScreen: View {
    @Environment(AppMainRouter.self) var router
    @StateObject private var viewModel = VerifyOTPViewModel()
    @FocusState private var isFocused: Bool // FocusState for keyboard control
    
    var phoneNumber: String
    var verificationID: String
    
    init(phoneNumber: String, verificationID: String) {
        self.phoneNumber = phoneNumber
        self.verificationID = verificationID
    }
    
    var body: some View {
        VStack {
            // App Logo
            Image(systemName: "widget.large.badge.plus") // Replace with your actual logo
                .symbolRenderingMode(.multicolor)
                .font(Font.system(size: 100, weight: .bold))
                .foregroundColor(Color.secondaryColor)
                .padding(.top, 50)
            
            
            
            TextField("Enter OTP", text: $viewModel.otp)
                .foregroundColor(.primaryTextColor)
                .keyboardType(.decimalPad)
                .textContentType(.oneTimeCode)
                .padding()
                .frame(height: 50)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .focused($isFocused) // FocusState to manage keyboard
                .submitLabel(.send)
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .toolbar { // Toolbar for Done button
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        
                        Button(action: {
                            isFocused = false // Dismiss the keyboard
                        }) {
                            Text("Done")
                                .foregroundColor(.primaryTextColor)
                        }
                    }
                }
            
            
            Spacer()
            
            
            
            // Submit Button
            Button(action: viewModel.verifyOTP) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    Text("Verify OTP")
                        .foregroundColor(.secondaryColor)
                        .font(.system(size: 16, weight: .semibold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.primaryColor)
                        .cornerRadius(8)
                }
            }
            .padding(.bottom, 10)
            .padding(.horizontal, 20)
            .disabled(viewModel.isLoading || viewModel.otp.isEmpty)
            
            Text("By Continuing, you agree to our Terms of Service and Privacy Policy.")
                .foregroundColor(.secondary)
                .font(.caption)
            
            // Error Message
            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.top, 10)
            }
            
        }
        .padding()
        .onAppear {
            self.addNavigationSubscriber()
            self.viewModel.configureDetails(withPhoneNumber: phoneNumber, verificationID: verificationID)
        }
        .navigationBarBackButtonHidden(false)
    }
    
    func addNavigationSubscriber() {
        self.viewModel.cancelSubs()
        
        self.viewModel.navigationPublisher.sink { path in
            router.pushToScreen(route: path)
        }
        .store(in: &viewModel.navigationCancellable)
    }
}

#Preview {
    var router = AppMainRouter()
    VerifyOTPScreen(phoneNumber: "", verificationID: "")
        .environment(router)
}

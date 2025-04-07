//
//  LoginScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI

struct LoginScreen: View {
    @Environment(AppMainRouter.self) var router
    @StateObject private var viewModel = LoginViewModel()
    @FocusState private var isFocused: Bool // FocusState for keyboard control
    
    var body: some View {
        VStack {
            // App Logo
            Image(systemName: "widget.large.badge.plus") // Replace with your actual logo
                .symbolRenderingMode(.multicolor)
                .font(Font.system(size: 100, weight: .bold))
                .foregroundColor(Color.secondaryColor)
                .padding(.top, 50)
            
            
            // Country Code and Phone Number Field
            HStack(spacing: 10) {
                Picker("Country Code", selection: $viewModel.countryCode) {
                    ForEach(viewModel.countryCodes, id: \.self) { code in
                        Text(code)
                    }
                }
                .tint(.primaryTextColor)
                .pickerStyle(MenuPickerStyle())
                .frame(height: 50)
                .padding(.leading, 10)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                
                TextField("Enter phone number", text: $viewModel.phoneNumber)
                    .foregroundColor(.primaryTextColor)
                    .keyboardType(.phonePad)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .textContentType(.telephoneNumber)
                    .padding()
                    .frame(height: 50)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .focused($isFocused) // FocusState to manage keyboard
                    .submitLabel(.done)
            }
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
            Button(action: viewModel.sendOTP) {
                if viewModel.isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    Text("Get OTP")
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
            .disabled(viewModel.isLoading || viewModel.phoneNumber.isEmpty)
            
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
        }
        .navigationBarBackButtonHidden(true)
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
    LoginScreen()
        .environment(router)
}

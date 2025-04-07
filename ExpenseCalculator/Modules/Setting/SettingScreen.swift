//
//  SettingScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 29/03/25.
//

import SwiftUI

struct SettingScreen: View {
    @Environment(AppMainRouter.self) var router
    
    var body: some View {
        VStack {
            Button {
                router.pushToScreen(route: .accountSetting)
            } label: {
                Text("Account Setting")
                    .foregroundColor(.primaryBtnTitleColor)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.primaryColor)
                    .cornerRadius(8)
            }
        }
        .navigationTitle(Text("Setting"))
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(false)
    }
}

#Preview {
    SettingScreen()
}

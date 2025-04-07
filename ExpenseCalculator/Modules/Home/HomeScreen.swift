//
//  HomeScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 23/03/25.
//

import SwiftUI

struct HomeScreen: View {
    @Environment(AppMainRouter.self) var router
    
    var body: some View {
        VStack {
            Text("Home Screen")
                .foregroundColor(.primaryTextColor)
        }
            .navigationTitle(Text("Home"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        debugPrint("Settings")
                        router.pushToScreen(route: .setting)
                    }) {
                        Image(systemName: "gearshape")
                            .foregroundColor(.primaryTextColor)
                    }
                }
            }
            .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeScreen()
}

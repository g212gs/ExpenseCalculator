//
//  AddExpenseScreen.swift
//  ExpenseCalculator
//
//  Created by Gaurang Lathiya on 12/04/25.
//

import SwiftUI

struct AddExpenseScreen: View {
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject var viewModel = AddExpenseViewModel()
    @State var selectedIndex: Int = 0
    @FocusState var textfieldFocus: Bool
    
    
    let maxLength = 5 // We can make it anything
    
    
    var body: some View {
        VStack {
            Spacer()
            
            GeometryReader { geo in
                TabView(selection: $selectedIndex) {
                    ForEach(viewModel.expenseList.indices, id: \.self) { index in
                        VStack(spacing: 20) {
                            Image(viewModel.expenseList[index].icon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: geo.size.width)
                            
                            Spacer()
                            
                            Text(viewModel.expenseList[index].name)
                                .font(.headline)
                                .padding(.bottom, 40)
                        }
                        .tag(index)
                    }
                }
                .onChange(of: selectedIndex) { _, newValue in
                    viewModel.resetExpenseAmount()
                }
                .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                .padding(.top, 20)
            }
            
            CurrencyField(value: $viewModel.expenseAmt)
                .multilineTextAlignment(.center)
                .font(.system(size: 60, weight: .medium))
                .focused($textfieldFocus)
                .onChange(of: viewModel.expenseAmt) { _, newValue in
                    if newValue.description.count > maxLength {
                        viewModel.expenseAmt = Decimal(Double(String(newValue.description.prefix(maxLength))) ?? 0)
                    }
                }
                .padding(.top, 10)
                .padding(.bottom, 10)
            
            Spacer()
            
            HStack {
                if (textfieldFocus) {
                    Spacer()
                    
                    Button {
                        textfieldFocus = false
                    } label: {
                        Text("Done")
                            .foregroundColor(.primaryTextColor)
                    }
                    .padding()
                } else {
                    Button {
                        textfieldFocus = false
                        viewModel.addExpense(withIndex: selectedIndex)
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Add Expense")
                            .foregroundColor(.secondaryColor)
                            .font(.system(size: 16, weight: .semibold))
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.primaryColor)
                            .cornerRadius(8)
                    }
                    .padding(.bottom, 20)
                    .padding(.horizontal, 20)
                }
            }
            .padding(.all, 0)
            .background(textfieldFocus ? Color.gray.opacity(0.2) : Color.clear)
        }
    }
    
}

#Preview {
    AddExpenseScreen()
}

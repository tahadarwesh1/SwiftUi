//
//  AddView.swift
//  iExpense
//
//  Created by Taha Darwish on 26/12/2023.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = "Name"
    @State private var type = "Personal"
    @State private var amount = 0.0
    let types = ["Personal" , "Business"]
    var expenses : Expenses
    var body: some View {
        NavigationStack {
            List {
                TextField("Name", text: $name)
                Picker(type, selection: $type){
                    ForEach(types , id: \.self){
                        Text($0)
                    }
                }
                TextField("Amount", value: $amount, format: .currency(code: "USD"))
                    .keyboardType(.decimalPad)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save"){
                        let item = ExpenseItem(name: name, type: type, amount: amount)
                        if(!item.name.isEmpty) {
                            expenses.items.append(item)
                            dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}

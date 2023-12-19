//
//  ContentView.swift
//  WeSplit
//
//  Created by Taha Darwish on 13/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPersons = 2
    @State private var tipPercentage = 20
    @FocusState private var isFocused
    let tipPercentages = [0,10,15,20,25,30]
    var totalAmount : Double {
        let selectedTip = Double(tipPercentage)
        let tipAmount = selectedTip / 100 * checkAmount
        let totalAmount2 = checkAmount + tipAmount
        return totalAmount2
    }
    var totalPerPerson : Double {
        let peopleCount = Double(numberOfPersons + 1)
        let personAmount = totalAmount / peopleCount
        return personAmount
    }
    var body: some View {
        NavigationStack {
            Form {
                
                Section {
                    TextField("Enter the amount", value:$checkAmount , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Enter the number of people", selection: $numberOfPersons){
                        ForEach(1..<100){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("How much tip do you want to leave?") {
                    Picker("Tip Percentage",selection: $tipPercentage){
                        ForEach(0..<101){
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Amount per person") {
                    Text(totalPerPerson , format: .currency(code: Locale.current.currency?.identifier ?? "USD "))
                }
                Section("Total Amount(Check + Tip Amount)") {
                    Text(totalAmount , format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .foregroundColor(tipPercentage == 0 ? .red : .none)
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if(isFocused){
                    Button("Done"){
                        isFocused = false
                    }
                }
            }

        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

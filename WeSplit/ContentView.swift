//
//  ContentView.swift
//  WeSplit
//
//  Created by Razvan Pricop on 29.09.24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount: Double = 0
    @State private var numberOfPeople: Int = 2
    @State private var tipPercentage: Int = 15
    let tipPercentages: [Int] = [10, 15, 20, 25, 0]
    
    @FocusState private var amountIsFocused: Bool
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount * tipSelection / 100
        let grandTotal = checkAmount + tipValue
        
        return grandTotal / peopleCount
    }
    
    var totalAmount: Double {
        checkAmount + checkAmount * Double(tipPercentage) / 100
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Check amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                    .pickerStyle(.menu)
                }
                
                Section("How much tip do you want to leave?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0..<101, id: \.self) { tipPercentage in
                            Text("\(tipPercentage)%")
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section("Total amount to pay") {
                    Text("\(totalAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                }
                
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}

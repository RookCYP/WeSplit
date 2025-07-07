//
//  ContentView.swift
//  WeSplit
//
//  Created by Rook on 29.06.2025.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipsPercentage = 20
    @FocusState private var amountIsFocused: Bool
    
    var totalCheckAmount : Double{
        let tips = Double(tipsPercentage)
        let checkAmount = Double(checkAmount)
        
        var totalCheck = checkAmount / 100 * tips + checkAmount
        return totalCheck
    }
    
    var totalPerPerson : Double{
        let peopleCount = Double(numberOfPeople + 2)
            let tipSelection = Double(tipsPercentage)

            let tipValue = checkAmount / 100 * tipSelection
            let grandTotal = checkAmount + tipValue
            let amountPerPerson = grandTotal / peopleCount

            return amountPerPerson
    }
    
    let tipPercentages: [Int] = [0, 10, 15, 20, 25]
    
    
    var body: some View {
        NavigationStack{
            Form {
                Section {
                    TextField("Check amount", value : $checkAmount, format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section("How much you want to tip?") {
                    Picker("Tips percents",selection : $tipsPercentage) {
                        ForEach(0..<101) {
                            Text($0, format : .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                
                Section ("Сумма чека"){
                    Text(totalCheckAmount, format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                
                Section ("Сумма на человека"){
                    Text(totalPerPerson, format : .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar{
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
    

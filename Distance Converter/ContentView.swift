//
//  ContentView.swift
//  Distance Converter
//
//  Created by Azimjonoff on 08/08/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var inputScale = "meters"
    @State private var inputValue = 0.0
    @State private var outputScale = "meters"
    @FocusState private var isFocused: Bool
    
    var result: Double {
        var inMeters = 0.0
        
        switch inputScale {
        case "meters":
            inMeters = inputValue
        case "feet":
            inMeters = 0.305 * inputValue
        case "yards":
            inMeters = 0.914 * inputValue
        case "miles":
            inMeters = 1609.344 * inputValue
        default:
            inMeters = 0
        }
        
        switch outputScale {
        case "feet":
            return (inMeters / 0.305)
        case "yards":
            return (inMeters / 0.914)
        case "miles":
            return (inMeters / 1609.344)
        default:
            return inMeters
        }
    }
    
    let scales = ["meters", "feet", "yards", "miles"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Picker("Input unit", selection: $inputScale) {
                        ForEach(scales, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Choose the input unit")
                }
                
                Section {
                    TextField("Input", value: $inputValue, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                } header: {
                    Text("Input the value")
                }
                
                Section {
                    Picker("Input unit", selection: $outputScale) {
                        ForEach(scales, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Choose the output unit")
                }
                
                Section {
                    Text("\(inputValue) \(inputScale) equals to " + String(format: "%.3f", result) + " \(outputScale)")
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle("Distance Converter")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    
                    Button("Done") {
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

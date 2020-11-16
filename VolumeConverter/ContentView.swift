//
//  ContentView.swift
//  VolumeConverter
//
//  Created by Michele Volpato on 16/11/2020.
//

import SwiftUI

enum ConversionUnit: String, CaseIterable {
    case milliliters, liters, cups, pints, gallons

    var asMilliliters: Double {
        switch self {
        case .milliliters:
            return 1
        case .liters:
            return 1000
        case .cups:
            return 284.131
        case .pints:
            return 568.261
        case .gallons:
            return 4546.0964008947
        }
    }
}

struct ContentView: View {
    @State private var amountToConvert = ""
    @State private var fromUnitIndex = 0
    @State private var toUnitIndex = 0

    private let units = ConversionUnit.allCases

    private var convertedAmount: Double {
        let doubleToConvert = Double(amountToConvert) ?? 0
        let millilitersToConvert = units[fromUnitIndex].asMilliliters * doubleToConvert
        let toUnitAsMilliliters = units[toUnitIndex].asMilliliters

        return millilitersToConvert / toUnitAsMilliliters
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount to convert", text: $amountToConvert)
                        .keyboardType(.decimalPad)
                }
                Section(header: Text("From")) {
                    Picker("From", selection: $fromUnitIndex) {
                        ForEach(0..<units.count) {
                            Text(units[$0].rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Section(header: Text("To")) {
                    Picker("To", selection: $toUnitIndex) {
                        ForEach(0..<units.count) {
                            Text(units[$0].rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("\(amountToConvert) \(units[fromUnitIndex].rawValue) in \(units[toUnitIndex].rawValue):")) {
                    Text("\(convertedAmount, specifier: "%.4f")")
                }
            }
            .navigationBarTitle("Volume conversion")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

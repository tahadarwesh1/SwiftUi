//
//  ContentView.swift
//  BetterRest
//
//  Created by Taha Darwish on 21/12/2023.
//
import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    @State private var sleepTime = Date.now.formatted(date: .omitted, time: .shortened)
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    static var defaultWakeTime: Date {
            let components = DateComponents(hour: 7, minute: 0)
            return Calendar.current.date(from: components) ?? Date.now
        }
    var body: some View {
        NavigationStack {
            Form {
                VStack(alignment: .leading) {
                    Text("When do you want to wake up")
                        .font(.headline)
                    DatePicker("", selection: $wakeUp,displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }
                VStack(alignment: .leading) {
                    Text("Desired amount of sleep")
                        .font(.headline)
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25 )
                }

                VStack(alignment: .leading) {
                    Text("Daily coffee intake")
                        .font(.headline)
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount , in: 1...20)
                    Picker("^[\(coffeeAmount) cup](inflect: true)", selection: $coffeeAmount){
                        ForEach(0..<21) { number in
                            Text("\(number)")
                        }
                    }
                }
            }
//            Form {
//                Section("When do you want to wake up") {
//                    DatePicker("", selection: $wakeUp,displayedComponents: .hourAndMinute)
//                        .labelsHidden()
//                }
//                Section("Desired amount of sleep") {
//                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25 )
//                }
//
//                Section("Daily coffee intake") {
//                    Stepper("^[\(coffeeAmount) cup](inflect: true)", value: $coffeeAmount , in: 1...20)
//                }
                
//            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedTime)
            }
            .alert(alertTitle, isPresented: $showAlert){
                Button("OK"){}
            } message: {
                Text(alertMessage)
            }
            
        }
    }
    func calculateBedTime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let components = Calendar.current.dateComponents([.hour,.minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            let prediction = try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeeAmount))
            sleepTime = (wakeUp - prediction.actualSleep).formatted(date: .omitted, time: .shortened)
            showAlert = true
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime
            print("prediction is \(sleepTime)")
            print("prediction is \(prediction.actualSleep)")
        } catch {
            // catch error
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Date {
    func formatTime() -> Date.FormatStyle.FormatOutput {
        self.formatted(.dateTime.hour().minute())
    }
}

//
//  ContentView.swift
//  iExpense
//
//  Created by Taha Darwish on 25/12/2023.
//
import SwiftUI

struct ExpenseItem : Identifiable , Codable{
    var id = UUID()
    let name : String
    let type : String
    let amount : Double
}

class Expenses : ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            if let itemsEncoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(itemsEncoded, forKey: "Expenses")
            }
        }
    }
    init(){
        if let savedItems = UserDefaults.standard.data(forKey: "Expenses"){
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View{
    @StateObject private var expenses = Expenses()
    @State private var showingSheet = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.name)")
                                .font(.headline)
                            Text(item.type)
                        }
                        Spacer()
                        Text(item.amount, format: .currency(code: Locale.current.currencyCode ?? "USD"))
                    }
                }
                .onDelete(perform: deleteItem)
            }
            .navigationTitle("IExpense")
            .toolbar {
                NavigationLink(destination: AddView(expenses: expenses)){
                    Text("Add Expense")
                }
            }
        }
//        .sheet(isPresented: $showingSheet){
//            AddView(expenses: expenses)
//        }
    }
    
    func deleteItem(at offsets : IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

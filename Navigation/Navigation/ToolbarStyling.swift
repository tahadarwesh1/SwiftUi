//
//  ToolbarStyling.swift
//  Navigation
//
//  Created by Taha Darwish on 31/12/2023.
//

import SwiftUI

struct ToolbarStyling: View {
    @State private var navigationTitle = "SwiftUi"
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<100) { i in
                    NavigationLink("Select \(i)", value: i)
                        .navigationDestination(for: Int.self){selection in
                            Text("your selection is \(selection)")
                        }
                }
            }
            .navigationTitle($navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ToolbarStyling()
}

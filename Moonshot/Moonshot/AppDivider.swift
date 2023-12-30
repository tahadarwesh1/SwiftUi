//
//  AppDivider.swift
//  Moonshot
//
//  Created by Taha Darwish on 30/12/2023.
//

import SwiftUI

struct AppDivider: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackGround)
            .padding(.vertical)
    }
}

#Preview {
    AppDivider()
}

//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Taha Darwish on 18/12/2023.
//

import SwiftUI

struct CapsuleText : View {
    var text:String
    var backgroundColor: Color

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .foregroundStyle(.white)
            .background(backgroundColor)
            .clipShape(Capsule())
    }
}

struct TitleModifier : ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundStyle(.white)
            .padding()
            .background(.blue)
            .clipShape(Rectangle())
            .cornerRadius(16)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(TitleModifier())
    }
}

struct Watermark: ViewModifier {
    var text: String

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
            Text(text)
                .font(.caption)
                .foregroundStyle(.white)
                .padding(5)
                .background(.black)
        }
    }
}

extension View {
    func watermarked(with text: String) -> some View {
        modifier(Watermark(text: text))
    }
}

struct ContentView: View {
    
    var body: some View {
        VStack {
            CapsuleText(text: "taha",backgroundColor: .red)
            CapsuleText(text: "Ahmed",backgroundColor: .yellow)
            Text("Hello from the other side")
                .modifier(TitleModifier())
            Color.red
                .frame(width: 200 , height: 200)
                .watermarked(with: "Created by Taha")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

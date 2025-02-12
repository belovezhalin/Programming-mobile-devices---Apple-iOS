//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by belovezhalin on 09/02/2025.
//

import SwiftUI

struct ProminentTitleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
            .fontWeight(.bold)
    }
}

extension View {
    func prominentTitle() -> some View {
        self.modifier(ProminentTitleModifier())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
                    Text("Welcome to My App")
                        .prominentTitle()
                    
                    Text("This is a subtitle")
                        .font(.title)
                        .foregroundColor(.gray)
                }
                .padding()
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    @ViewBuilder let content: (Int, Int) -> Content

    var body: some View {
        VStack {
            ForEach(0..<rows, id: \.self) { row in
                HStack {
                    ForEach(0..<columns, id: \.self) { column in
                        content(row, column)
                    }
                }
            }
        }
    }
}

struct ContentView4: View {
    var body: some View {
        GridStack(rows: 4, columns: 4) { row, col in
            Image(systemName: "\(row * 4 + col).circle")
            Text("R\(row) C\(col)")
        }
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

struct ContentView3: View {
    var body: some View {
        Color.blue
            .frame(width: 300, height: 200)
            .watermarked(with: "Hacking with Swift")
    }
}

struct CapsuleText: View {
    var text: String

    var body: some View {
        Text(text)
            .font(.largeTitle)
            .padding()
            .background(.blue)
            .clipShape(.capsule)
    }
}

struct ContentView2: View {
    var body: some View {
        VStack(spacing: 10) {
            CapsuleText(text: "First")
                .foregroundStyle(.white)
            CapsuleText(text: "Second")
                .foregroundStyle(.yellow)
        }
    }
}

struct ContentView1: View {
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("nunquam titillandus")
    
    @ViewBuilder var spells1: some View {
        Text("Lumos")
        Text("Obliviate")
    }
    
    var spells: some View {
        Group {
            Text("Lumos")
            Text("Obliviate")
        }
    }

    var body: some View {
        VStack {
            motto1
                .foregroundStyle(.red)
            motto2
                .foregroundStyle(.blue)
        }
    }
}

#Preview {
    ContentView()
    ContentView1()
    ContentView2()
    ContentView3()
    ContentView4()
}

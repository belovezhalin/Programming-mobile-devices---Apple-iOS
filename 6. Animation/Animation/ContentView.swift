//
//  ContentView.swift
//  Animation
//
//  Created by belovezhalin on 09/02/2025.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint

    func body(content: Content) -> some View {
        content
            .rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot: AnyTransition {
        .modifier(
            active: CornerRotateModifier(amount: -90, anchor: .topLeading),
            identity: CornerRotateModifier(amount: 0, anchor: .topLeading)
        )
    }
}

struct ContentView: View {
    @State private var animationAmount = 0.0
    @State private var enabled = false
    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    let letters = Array("Drag for animation")
    
    var body: some View {
        ZStack {
            Button("Tap Me") {
                withAnimation {
                    isShowingRed.toggle()
                }
            }

            if isShowingRed {
                Rectangle()
                    .fill(.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
        .onTapGesture {
            withAnimation {
                isShowingRed.toggle()
            }
        }
        
        HStack(spacing: 0) {
            ForEach(0..<letters.count, id: \.self) { num in
                Text(String(letters[num]))
                    .padding(5)
                    .background(enabled ? .blue : .red)
                    .offset(dragAmount)
                    .animation(.linear.delay(Double(num) / 20), value: dragAmount)
                    }
                }
                .gesture(
                    DragGesture()
                        .onChanged { dragAmount = $0.translation }
                        .onEnded { _ in
                            dragAmount = .zero
                            enabled.toggle()
                        }
                )
        
        LinearGradient(colors: [.yellow, .red], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .frame(width: 300, height: 200)
                    .clipShape(.rect(cornerRadius: 10))
                    .offset(dragAmount)
                    .gesture(
                        DragGesture()
                            .onChanged { dragAmount = $0.translation }
                            .onEnded { _ in
                                withAnimation(.bouncy) {
                                    dragAmount = .zero
                                }
                            }
                    )
        
        Button("Tap Me") {
            enabled.toggle()
        }
        .frame(width: 200, height: 200)
        .background(enabled ? .blue : .red)
        .animation(nil, value: enabled)
        .foregroundStyle(.white)
        .clipShape(.rect(cornerRadius: enabled ? 60 : 0))
        .animation(.spring(duration: 1, bounce: 0.6), value: enabled)
        
        Button("Tap Me") {
            withAnimation(.spring(duration: 1, bounce: 0.5)) {
                animationAmount += 360
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
    }
    
}

#Preview {
    ContentView()
}

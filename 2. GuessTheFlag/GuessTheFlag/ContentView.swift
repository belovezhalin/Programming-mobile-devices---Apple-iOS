//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by belovezhalin on 04/12/2024.
//

import SwiftUI

struct FlagImage: View {
    var country: String
    
    var body: some View {
        Image(country)
            .clipShape(.capsule)
            .shadow(radius: 2)
    }
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var currentScore = 0
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var questionCount = 0
    @State private var showingFinalAlert = false
    
    @State private var spinDegrees = 0.0
    @State private var opacity = 1.0
    @State private var scale = 1.0
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
            ], center: .top, startRadius: 200, endRadius: 400)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the text of ")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                                .rotation3DEffect(
                                    .degrees(number == correctAnswer ? spinDegrees : 0),
                                                axis: (x: 0, y: 1, z: 0)
                                )
                                .opacity(number == correctAnswer ? 1 : opacity)
                                .scaleEffect(number == correctAnswer ? 1 : scale)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Score: \(currentScore)")
                .foregroundStyle(.white)
                .font(.title.bold())
        }
        .alert("Game Over", isPresented: $showingFinalAlert) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is \(currentScore)")
                .foregroundStyle(.white)
                .font(.title.bold())
        }
    }
    
    func askQuestion() {
        if questionCount == 8 {
            showingFinalAlert = true
        }
        else {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
        
        spinDegrees = 0
        opacity = 1
        scale = 1
    }
    
    func flagTapped(_ number: Int) {
        withAnimation {
            spinDegrees = 360
            opacity = 0.25
            scale = 0.8
        }
        
        if number == correctAnswer {
            scoreTitle = "Correct!"
            currentScore += 10
        } else {
            scoreTitle = "Wrong... \n That's the flag of \(countries[correctAnswer])!"
            currentScore -= 5
        }
        showingScore = true
        questionCount += 1
    }
    
    func resetGame() {
        questionCount = 0
        currentScore = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}

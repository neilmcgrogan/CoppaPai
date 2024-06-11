//
//  LapalaEndView.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/25/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct LapalaEndView: View {
    @StateObject var game: LapalaGameModel
    @Binding var results: Bool
    let localWidth = isIPad() ? (startedInLandscape ? width * 0.50 : width * 0.60) : width
    
    var body: some View {
        VStack(spacing: 30) {
            Button(action: {
                withAnimation() {
                    self.results.toggle()
                }
            }) {
                HStack(spacing: 50) {
                    Text("Finished!")
                    
                    Image(systemName: "xmark")
                }
                .padding(.horizontal, 16)
                .font(.title)
                .bold()
            }
            
            Text("Puzzle solved in \(game.words.count) words.\nNext time try in \(game.words.count-1)!")
                .font(.subheadline)
                .foregroundStyle(Color.dark_gray)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            
            lineSection
            
            Button(action: {
                game.gameRestart()
            }) {
                Text("Play again")
                    .font(.title)
                    .button(selectable: true)
            }
            .padding()
        }
        .padding()
        .background(Color.primary_pink)
        .gameMenuViewStyle()
        .shadow(radius: 10)
        .padding()
    }
    
    private var lineSection: some View {
        GeometryReader { geo in
            ForEach(game.words, id: \.self) { word in
                ForEach(0..<word.count, id: \.self) { index in
                    if index != 0 {
                        let startIndex = word.index(word.startIndex, offsetBy: index - 1)
                        let endIndex = word.index(word.startIndex, offsetBy: index)
                        
                        let lhs = String(word[startIndex])
                        let rhs = String(word[endIndex])
                        
                        let pathResult = game.returnPath(lhs: lhs, rhs: rhs)
                        
                        Line(
                            from: CGPoint(x: ((geo.size.width / 2) * pathResult.0.x), y: ((geo.size.height / 2) * pathResult.0.y)),
                            to: CGPoint(x: ((geo.size.width / 2) * pathResult.1.x), y: ((geo.size.height / 2) * pathResult.1.y))
                        )
                        .stroke(Color.primary_pink.opacity(0.2), style: StrokeStyle(lineWidth: 3))
                    }
                }
            }
        }
        .padding(25)
        .frame(width: localWidth * 0.25, height: localWidth * 0.25)
        .scaleEffect(game.scoreAnimation ? 0.95 : 1.0)
        .transition(.scale)
    }
}

@available(iOS 16.0, *)
struct RestartView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.primary_pink.edgesIgnoringSafeArea(.all)
            LapalaEndView(game: LapalaGameModel(), results: .constant(false))
                .environmentObject(LapalaGameModel())
        }
    }
}

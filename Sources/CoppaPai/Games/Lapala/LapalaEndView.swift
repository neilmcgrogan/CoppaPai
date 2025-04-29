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
                HStack {
                    Text("Finished!")
                    Spacer()
                    Image(systemName: "xmark")
                        .font(.title3)
                        .fontWeight(.black)
                }
                .bold()
                .font(.title)
            }
            
            Text("**Puzzle solved in \(game.words.count) words.**\n(Every puzzle is solvable in 2 words!)")
                .font(.subheadline)
                .fontWeight(.light)
                .multilineTextAlignment(.center)
            
            lineSection
            
            Spacer()
            
            Button(action: {
                game.gameRestart()
            }) {
                Text("Play again")
                    .font(.title)
                    .foregroundColor(Color.black)
                    .padding(.vertical, 20)
                    .frame(maxWidth: width)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(Color.white)
                    )
                    .springEffect(animationTrigger: true)
                
            }
            .padding()
            .springEffect(animationTrigger: true)
            .padding(20)
        }
        .padding()
        .background(Color.primary_pink)
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
                        .stroke(Color.black.opacity(0.5), style: StrokeStyle(lineWidth: 3))
                    }
                }
            }
        }
        .padding(25)
        .frame(width: localWidth * 0.45, height: localWidth * 0.45)
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

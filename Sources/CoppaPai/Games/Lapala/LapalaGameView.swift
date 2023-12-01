//
//  LapalaGameView.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/24/23.
//

import SwiftUI

private let localHeight = UIScreen.main.bounds.height

@available(iOS 16.0, *)
public struct LapalaGameView: View {
    @EnvironmentObject var game: LapalaGameModel
    
    @Binding public var askFeedback: Bool
    
    @State private var viewState = CGSize.zero
    
    public init(askFeedback: Binding<Bool>) {
        self._askFeedback = askFeedback
    }
    
    let localWidth = isIPad() ? (startedInLandscape ? width * 0.50 : width * 0.60) : width
    
    public var body: some View {
        ZStack {
            switch game.status {
            case .notPlaying:
                LapalaTitleView()
            default:
                titleSection
                
                wordsSection
                
                arrowSection
                
                alertsSection
                
                Button(action: {
                    game.gameRestart()
                }) {
                    LapalaRestartView(game: game)
                        .background(Color.black.opacity(0.001))
                        .offset(y: game.status == .finished ? 0 : 2*localHeight)
                        .offset(y: viewState.height)
                        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0), value: game.status == .finished)
                }
                .foregroundColor(.black)
            }
        }
        .bold()
        .font(.largeTitle)
    }
}

@available(iOS 16.0, *)
extension LapalaGameView {
    private var alertsSection: some View {
        Text("Not in word bank")
            .font(.title3)
            .padding(5)
            .background(
                RoundedRectangle(cornerRadius: 15.0)
                    .fill(Color.white)
            )
            .opacity(game.incorrectGuess ? 1.0 : 0.0)
            .transition(.opacity)
    }

    private var titleSection: some View {
        VStack(spacing: 0) {
            Text(" \(game.guess) ")
                .foregroundColor(.black)
                .bold()
                .shake(self.$game.incorrectGuess)
            Color.black.frame(width: localWidth * 0.5, height: 5)
            Text("Try to solve in 6 words")
                .font(.body)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(game.words, id: \.self) { word in
                        Text("\(word)")
                            .padding(.leading)
                    }
                }
                .font(.title3)
            }
            
            Spacer()
            
            HStack(spacing: 20) {
                Button(action: {
                    game.restart()
                }) {
                    Text("Restart")
                        .button(selectable: game.guess.count > 0 ? true : false)
                }
                
                Button(action: {
                    game.delete()
                }) {
                    Text("Delete")
                        .button(selectable: game.deletable() ? true : false)
                }
                
                Button(action: {
                    if self.game.guess.count > 2 && !self.game.entered { game.enter() }
                }) {
                    Text("Enter")
                        .button(selectable: game.guess.count > 2 ? true : false)
                }
            }
            .font(.body)
            .foregroundColor(.black)
            
            ProgressView("", value: game.progress, total: 1)
                .accentColor(Color.black)
                .frame(width: localWidth * 0.75)
        }
        .scaleEffect(game.status == .finished ? 0 : 1)
    }
    
    private var wordsSection: some View {
        GeometryReader { geo in
            ForEach(0...11, id: \.self) { index in
                    Button(game.char[index]) {
                        game.validateMove(candidate: index)
                    }
                    .foregroundColor(game.containsLetter(letter: game.char[index]) ? .black : .white)
                    .background(BackgroundView(isMatching: String(game.guess.last ?? "#") == game.char[index] ? true : false))
                    .offset(x: ((geo.size.width / 2) * locations[index].x) + pointOffset[index].x, y: ((geo.size.height / 2) * locations[index].y) + pointOffset[index].y)
                    .offset(x: game.char[index] == "I" ? -5 : -12, y: -17.5)
            }
            
            Color.white.opacity(0.75)
            
            VStack(spacing: 0) {
                Color.black.frame(height: 3, alignment: .top)
                Spacer()
                Color.black.frame(height: 3, alignment: .bottom)
            }
            
            HStack(spacing: 0) {
                Color.black.frame(width: 3, alignment: .leading)
                Spacer()
                Color.black.frame(width: 3, alignment: .trailing)
            }
        }
        .padding(25)
        .frame(width: localWidth * 0.75, height: localWidth * 0.75)
        .scaleEffect(game.scoreAnimation ? 0.95 : 1.0)
        .transition(.scale)
    }
    
    private var arrowSection: some View {
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
            
            ForEach(0..<game.guess.count, id: \.self) { index in
                if index > 0 {
                    let lhsIndex = game.guess.index(game.guess.startIndex, offsetBy: index - 1)
                    let rhsIndex = game.guess.index(game.guess.startIndex, offsetBy: index)

                    let lhs = String(game.guess[lhsIndex])
                    let rhs = String(game.guess[rhsIndex])

                    let pathResult = game.returnPath(lhs: lhs, rhs: rhs)

                    Line(
                        from: CGPoint(x: (geo.size.width / 2) * pathResult.0.x, y: (geo.size.height / 2) * pathResult.0.y),
                        to: CGPoint(x: (geo.size.width / 2) * pathResult.1.x, y: (geo.size.height / 2) * pathResult.1.y)
                    )
                    .stroke(Color.primary_pink, style: StrokeStyle(lineWidth: 3, dash: [10]))
                }
            }
            
            AnimatingLine(geo: geo, points: game.placeNew())
            
            ForEach(0...11, id: \.self) { index in
                ZStack {
                    Circle()
                        .fill(String(game.guess.last ?? "#") == game.char[index] ? Color.primary_pink : Color.black).frame(width: 12.5, height: 12.5)
                    Circle()
                        .fill(game.containsLetter(letter: game.char[index]) ? Color.black : Color.white).frame(width: 7.5, height: 7.5)
                }
                .offset(x: (geo.size.width / 2) * locations[index].x, y: (geo.size.height / 2) * locations[index].y)
                .offset(x: -6, y: -6.5)
            }
        }
        .padding(25)
        .frame(width: localWidth * 0.75, height: localWidth * 0.75)
        .scaleEffect(game.scoreAnimation ? 0.95 : 1.0)
        .transition(.scale)
    }
    
    func drawLine(from: CGPoint, to: CGPoint) -> some View {
        Line(from: from, to: to)
    }
}

@available(iOS 13.0, *)
struct BackgroundView: View {
    let isMatching: Bool
    
    var body: some View {
        Color(isMatching ? .black : .clear)
            .frame(width: 15, height: 2)
            .offset(y: 15)
    }
}

@available(iOS 16.0, *)
#Preview {
    LapalaGameView(askFeedback: .constant(false))
        .environmentObject(LapalaGameModel())
        .background(Color.primary_pink.edgesIgnoringSafeArea(.all))
}

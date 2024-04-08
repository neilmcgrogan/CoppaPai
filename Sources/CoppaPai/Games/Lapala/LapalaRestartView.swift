//
//  LapalaRestartView.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/25/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct LapalaRestartView: View {
    @StateObject var game: LapalaGameModel
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Completed!")
                .font(.title)
                .bold()
                .padding(.horizontal, 50)
            Text("in \(game.words.count) words")
                .font(.subheadline)
                .foregroundStyle(Color.dark_gray)
                .fontWeight(.light)
            Button(action: {
                game.gameRestart()
            }) {
                Image(systemName: "play.fill")
                    .font(.largeTitle)
                    .padding(35)
                    .springEffect(animationTrigger: true)
                    .foregroundColor(Color.black)
            }
            Button(action: {
                game.gameRestart()
            }) {
                Text("Play again")
                    .font(.title)
                    .button(selectable: true)
            }
        }
        .padding()
        .background(Color.primary_pink)
        .menuViewStyle()
        .padding()
    }
}


@available(iOS 16.0, *)
struct RestartView_Previews: PreviewProvider {
    static var previews: some View {
        LapalaRestartView(game: LapalaGameModel())
            .environmentObject(LapalaGameModel())
    }
}

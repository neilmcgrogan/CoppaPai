//
//  LapalaRestartView.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/25/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct LapalaRestartView: View {
    @StateObject var game: LapalaGameModel
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Completed!")
                .font(.title)
            Text("in \(game.words.count) words")
                .font(.body)
            Spacer()
            Image(systemName: "play.fill")
                .font(.largeTitle)
            Spacer()
            Text("Play again")
                .font(.title)
        }
        .foregroundColor(.white)
        .padding(20)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.primary_pink.cornerRadius(50))
        .shineEffect(animationTrigger: .constant(true))
        .springEffect(animationTrigger: .constant(true))
        .shadow(radius: 20)
        .padding(50)
        .padding(.vertical, 75)
    }
}


@available(iOS 15.0, *)
struct RestartView_Previews: PreviewProvider {
    static var previews: some View {
        LapalaRestartView(game: LapalaGameModel())
            .environmentObject(LapalaGameModel())
    }
}

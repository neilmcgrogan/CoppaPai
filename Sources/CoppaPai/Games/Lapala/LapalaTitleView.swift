//
//  LapalaTitleView.swift
//  CoppaPai
//
//  Created by Neil McGrogan on 10/25/23.
//

import SwiftUI

@available(iOS 15.0, *)
struct LapalaTitleView: View {
    @EnvironmentObject var game: LapalaGameModel
    
    var body: some View {
        VStack {
            Text("Letter Box")
                
            Spacer()
            
            Button(action: {
                withAnimation { self.game.status = .playing }
                self.game.gamesPlayed += 1
            }) {
                Image(systemName: "play.fill")
                    .padding(100)
            }
            
            Spacer()
        }
        .foregroundColor(.white)
        .font(.largeTitle)
    }
}

